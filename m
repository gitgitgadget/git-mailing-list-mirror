From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Mon, 7 Jun 2010 23:14:58 -0300
Message-ID: <AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Jun 08 04:15:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLoLN-0004wH-O9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 04:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab0FHCPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 22:15:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43434 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0FHCO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 22:14:59 -0400
Received: by bwz11 with SMTP id 11so1055293bwz.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 19:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=YnD7E2pMtNhTx+zInZsjT8bdQZ7aOGQyIOE1vKwCV/I=;
        b=OSHJyx5vidXwXAepIyGj2rMsVSxQTKcrxj05bdw9IPa/IUoz4vlaeWNPsea2Q/VXTE
         gZ9d+QVx+cpc3Jxw/V0d46xsMfuAqkKV8BzMW1tGJI98rmMeewvOqez2VEJFThu4WYWF
         2p0GnkocAa87rWeYm5m/dM0rEF6LMyz5IElCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BO9eanFCwU9hHtSrkw/6YAdPXakQ9LO33k4O4BhYyJJJsSAiM91N9ZVHVn4jZ31yv4
         fV24pxkcdyk9AJExm3hXppiZKMcHVbFAbwCg73EoLIdcVWlNkVSy1UXaW/ltDWGfCohp
         /5YTvtZMIjrVQ2BRVA3tp3eHdGj33Ja63MUxs=
Received: by 10.204.81.7 with SMTP id v7mr497688bkk.140.1275963298081; Mon, 07 
	Jun 2010 19:14:58 -0700 (PDT)
Received: by 10.204.46.80 with HTTP; Mon, 7 Jun 2010 19:14:58 -0700 (PDT)
In-Reply-To: <1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2010 at 9:04 PM, Ben Walton <bwalton@artsci.utoronto.ca> wrote:
>
> Why not set a sensible DEFAULT_PAGER value for the system in your
> config.mak file instead?
>
> Just curious.
>

I was thinking about it before coding the patch, and found some
consequences. First of all, the most important thing I should
understand is that most users will install git from binary,
precompiled packages instead of the good download and compile. So this
is actually a good reason to not do it that way (config.mak)... Some
users may download the compiled binary while it's actually calling
it's default pager.

But this is not the only reason. Let me give you an example: We
develop (I'm actually working at Accenture) using several machines.
When we need some tool, we compile it in our first machine, and
install it for an specific user. In some other environments we cannot
compile things (testing environments) so we transfer (FTP) those
binary files. It's just another case, and the default pager could
cause problems here (in fact, i experienced such problems).

Another case (or something as the first one): If you installed less
(via your package system), then git, and then you happen to uninstall
less... should GIT be uninstalled in absence of it's default pager?

I think GIT must auto-detect it's pager based in what is on the system
at runtime, don't you think so?
