From: mat <matthieu.stigler@gmail.com>
Subject: Re: Looks like --amend create commit... don't understand
Date: Thu, 25 Feb 2010 21:45:06 +0100
Message-ID: <4B86E152.1060108@gmail.com>
References: <4B8599C4.1050409@gmail.com> <vpqr5oa9tu5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkkaO-0001zc-Nq
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 21:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700Ab0BYUpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 15:45:15 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:35632 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933667Ab0BYUpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 15:45:12 -0500
Received: by fxm19 with SMTP id 19so6706063fxm.21
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 12:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=EMqi7cMxNYpZ2MqZ88TPxmBPaiibNM2j8fPxTPAI9f4=;
        b=WikEMh+Zv8kbN/WuKLHBhPn1KPup76QvLy48jFSq6y7ZXhNiIshoqtXZeDa+RdSuyO
         5zexwmzofCm9ERbMbta84wLAEYjUB84Ip9/YJ9s70es40PIVDHcQr96FaiFWvC0CM2/J
         K260/RyGjOfdULFJHKiliWiiY++5emR9jiezU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=X/T2g8tZhxRvJ1ArbA8JBJiZn+sbeHRdmEFPuI3bhAm97OF4eSlUATEZnbUk0iBKbG
         jReWLAFxa+ma303u8GUfU0BwVp2jekIt1ArpVRUyfRqzmTEU5b9oseFVSKN++LqYYyMY
         TSqXFzLifOP2o675QtZmsdv12uFgwFOuohbII=
Received: by 10.223.77.139 with SMTP id g11mr353326fak.4.1267130711349;
        Thu, 25 Feb 2010 12:45:11 -0800 (PST)
Received: from ?192.168.178.21? (ip-28-110.sn2.eutelia.it [83.211.28.110])
        by mx.google.com with ESMTPS id 22sm897111fkr.59.2010.02.25.12.45.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 12:45:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <vpqr5oa9tu5.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141071>

Dear Matthieu

Thanks a lot for your patient help and clear explanations, it is now=20
much clearer for me!

Merci!

Matthieu


Matthieu Moy a =E9crit :
> mat <matthieu.stigler@gmail.com> writes:
>
>  =20
>> commits. But when looking on gitk, I see that
>> git commit blabla --amend
>>
>> does create each and every time a new commit,
>>    =20
>
> Yes. In Git, objects (including commits) are fundamentally immutable.
> You never modify an object, you create a new one, and usually forget
> about the old one.
>
>  =20
>> I mean: with git log,
>> there is only one commit, but on gitk, I see many, with the same nam=
e
>> but different revision ID....
>>    =20
>
> The revision ID is the sha1sum of the commit content. So, if they hav=
e
> different contents, they _must_ have different IDs.
>
> What happens is that you start with a history like
>
> A---B <- master
>
> and then try to --amend B. What happens is that you create a new B,
> say B', and let the branch you sit on point to this new one. Like:
>
> A---B
>  \
>   `-B' <- master
>
> Most of the time, B has just become unreachable: no branch contain it=
,
> no tag point to it, ... so you actually see
>
> A---B' <- master
>
> and it very much looks like you just modified B.
>
> Now, if you made B reachable before your commit --amend, like by
> pushing it to another repo, letting someone else pull from it, or if =
B
> is already part of another branch, then the situation is different.
>
> For example, if B is already part of a branch, like this:
>
>     .---- temp-branch
>     v
> A---B---C <- master
>
> If you do a checkout of temp-branch, then commit --amend, you end up
> in this situation :
>
> A---B---C <- master
>  \
>   `-B' <- temp-branch
>
> The solutions:
>
> * If you already published your commit, then don't amend it. Period.
>
> * If you want to rewrite an old commit in a branch, then read about
>   "git rebase -i", but make sure you read all the warnings about
>   rebase before you do so.
>
>  =20
