From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 3/3] completion: use specified file (if any) when 
	completing config vars
Date: Thu, 7 May 2009 12:55:11 -0700
Message-ID: <780e0a6b0905071255g4ade6316oace6a2be6a6d2@mail.gmail.com>
References: <1241676906-29783-1-git-send-email-bebarino@gmail.com> 
	<1241677093-29937-1-git-send-email-bebarino@gmail.com> <1241677093-29937-2-git-send-email-bebarino@gmail.com> 
	<20090507151207.GQ30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29hI-0007ef-FS
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762057AbZEGTzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761997AbZEGTzc
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:55:32 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:63630 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761944AbZEGTzb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 15:55:31 -0400
Received: by yw-out-2324.google.com with SMTP id 5so578914ywb.1
        for <git@vger.kernel.org>; Thu, 07 May 2009 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2FEfuOFVYsocaIkRlfUTEBLMfMLyXsChECJ2XkSJ6Ag=;
        b=rE6Y38liStGOLdPzVM+tbg+K8daNwfLUPonqAQ5LgJzOQdEIlh5LowFxLAwaiXjpK7
         9og06chjClnSenE8BclPv2nz7JZ1nW8mbCgyXiLykt4n9tVTAIvgod7VHeU9Eq8EV2U9
         /WWhTgd9U3B4aN3ntR/ehiBplYo0sc6K13RNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Zv3IM1Qwd22QajyhwsEl7+dm1Q4Bs46hNhQVX6F0nE5/Dh4qvNcQACtNDt6MjcgeYX
         yMLF5hKk0gVAH2m+VWvkLW6ke63P1npLusEh3BSOTl2xrCiYxmqndS4DoxXhk8Ax9+f6
         mI9VB7e2fMP7wt6gUuEZp1sDCY5idv2c6KXIs=
Received: by 10.100.171.13 with SMTP id t13mr4804198ane.1.1241726131165; Thu, 
	07 May 2009 12:55:31 -0700 (PDT)
In-Reply-To: <20090507151207.GQ30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118517>

On Thu, May 7, 2009 at 8:12 AM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Stephen Boyd <bebarino@gmail.com> wrote:
>> Only list the variables that can actually be affected by the command=
 by
>> searching the arguments for a config file setting.
>
> Wow, this is a lot of magic.
>
> Try:
>
> =C2=A0git config --global remote.gitster.url $(git config remote.o<TA=
B>
>
> You'll complete against --global, not the local repository.
>

Yeah, I didn't think it would be very robust. Is it a good idea to
keep going down this path, or is it too magical? This example could be
fixed by searching the words backwards, but I imagine there is some
other case where that will fail. Also, --global and --system don't
have values, so right now it's all wrong (i.e. config_file is
"--global remote.gitster.url" for this example).
