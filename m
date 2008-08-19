From: "Alexander E Genaud" <alex@genaud.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 12:09:44 +0200
Message-ID: <ee521d6f0808190309n7f0114a6q2e8113238cb2142b@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	 <48AA7BE9.4040108@sneakemail.com>
	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
	 <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
	 <vpqk5edid2y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Lists_Peter_Valdemar_M=C3=B8rch?=" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 19 12:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVOB5-0000AX-Jo
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 12:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbYHSKJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 06:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbYHSKJr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 06:09:47 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:53654 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbYHSKJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 06:09:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so635008gvc.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ycvlHO8aq+4+z0pViH38KOWSMImRKLrlSez/knEgXOI=;
        b=N6ob+EOcGupu9Xv6r9hSqBEaxuOCAw0PrXx1CIjbAIvLdcpCBBocUfoYOTc8R9et8o
         vmIO0/1XRg9IT5SE4C5eeS92OMiASdbBAxInLEF9QAMC6RW7iSkz/bSjGXprkMvJE01s
         0XPy87R7XaifjQ3Hu4AmvAVIiJ+iIHE/+u+p8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=xRC867EuRKrScxesHAUAzjt2G9rrxB2KpP7RWMBvt29JhJYPvw2HmSnsTbt4ZJ0LwB
         yJhOSn8P0uF0rWpQ0CYI9c1AU0ZLVF6Bqi08gCCXQe5kbun1XniSTwCTvHfh09SWa7rs
         rvZYsIBtupvQ/H47cOn61HnOATB2sZMPN8k94=
Received: by 10.103.246.17 with SMTP id y17mr4665270mur.55.1219140584348;
        Tue, 19 Aug 2008 03:09:44 -0700 (PDT)
Received: by 10.103.8.1 with HTTP; Tue, 19 Aug 2008 03:09:44 -0700 (PDT)
In-Reply-To: <vpqk5edid2y.fsf@bauges.imag.fr>
Content-Disposition: inline
X-Google-Sender-Auth: eba23c5d2b53256a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92844>

>> A single term for cache and index should be decided upon.
>
> +1 on this.
>
> I find "staging area" the most explicit wording for users, but I say
> that as a non-native english speaker.
>
> Unfortunately, it's not only a matter of documentation. Renaming "git
> diff --cached" to "git diff --staged" would cause backward
> compatibility problems for example.

Actually, I don't even think of the --cached argument as a flag but as
a reference. Consider INDEX and WORKSPACE as references:

git diff INDEX HEAD --name-status
  -- display staged files (git diff --cached)

git diff INDEX WORKSPACE --name-status
  -- display unstaged changes (git diff)

git diff HEAD WORKSPACE --name-status
  -- display changes since last commit (git diff HEAD)

Of course, --cached is not synonymous with INDEX in my example above,
thus despite getting use to it, default behavior seems chaotic to me.
Git-diff HEAD assumes the unspecified reference is WORKSPACE, while
git-diff --cached assumes the unspecified reference is HEAD. Git-diff
with no argument assumes the unspecified references as INDEX and
WORKSPACE. If I'm mistaken, it might just prove the point. ;-)

Cheers,
Alex


-- 
[ alex@genaud.net ][ http://genaud.net ]
[ B068 ED90 F47B 0965 2953 9FC3 EE9C C4D5 3E51 A207 ]
