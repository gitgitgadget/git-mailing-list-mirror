From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree, .gitattributes
Date: Fri, 23 Sep 2011 11:50:37 -0400
Message-ID: <CAG+J_Dz7uQcYjwEZrAg-h2GAwJ0gCjW2kw2Erz3UWGYcCeTAVQ@mail.gmail.com>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
	<1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
	<7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
	<4E7C5DC3.8030409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 23 17:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R781U-0000cX-VH
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 17:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab1IWPuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 11:50:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55612 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754834Ab1IWPui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 11:50:38 -0400
Received: by gwb15 with SMTP id 15so3816107gwb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zHfhKl+gP59e+7zkrKXdYyZrR81YUcgzmiv7uhtnjo4=;
        b=Lnrvu3qX2pmhGxWmmr9y3o1kKtIE2lSUe86aDhmGO3JoK0EbtqvMWBeNNW/4/0SNNG
         G/3XeOPS2O6tVdaDuqAdqLGo5VmqHllDX8mdj5/LlU0gpRFQekpvau4C3NLMvXMcpjRE
         3+5c5splLD5wk9iU9ppJ2u0Hj874KRDMxcoIY=
Received: by 10.147.54.19 with SMTP id g19mr3468735yak.21.1316793037435; Fri,
 23 Sep 2011 08:50:37 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 23 Sep 2011 08:50:37 -0700 (PDT)
In-Reply-To: <4E7C5DC3.8030409@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181973>

On Fri, Sep 23, 2011 at 6:21 AM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 09/23/2011 12:39 AM, Junio C Hamano wrote:
>> [...] It
>> would be a regression if the attributes mechanism is used for auditi=
ng
>> purposes (as we start reading from a tree that is being audited usin=
g the
>> very attributes it brings in), though.
>
> I'm confused by this comment.
>
> If an auditing system can be subverted by altering .gitattributes, th=
en
> I can do just as much harm by changing the .gitattributes in one comm=
it
> and making the "nasty" change in a second. =C2=A0So any rigorous audi=
ting
> system based on .gitattributes would have to prevent me from committi=
ng
> modifications to .gitattributes, in which case my commit will be
> rejected anyway.
>
> If by "auditing" you mean other less rigorous checks to which excepti=
ons
> are *allowed*, then it is preferable to add the exception in the same
> commit as the otherwise-offending content, and therefore it is
> *required* that the .gitattributes of the new tree be used when check=
ing
> the contents of that tree.

Currently, an auditing hook that cares about attributes, and which
runs in a bare repo, ignores the in-repo .gitattributes, considering
only the attributes set outside of the repo.

So by making git care about .gitattributes in a bare repo, such a hook
can suddenly be bypassed.

j.
