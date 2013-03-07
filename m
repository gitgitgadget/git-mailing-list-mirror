From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 15:00:56 +0000
Message-ID: <CALeLG_=xzL1SA0G63FGb5v8K5WQOUg4yaodNm6zwf7kU1pAYvg@mail.gmail.com>
References: <CALeLG_k=8S0Q-89CUvNPQT91gkJm1NdDN6YtCkdTQZZi9RUjWA@mail.gmail.com>
	<1721159119.197038.1362660611167.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Mar 07 16:01:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDcJx-0005Es-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 16:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084Ab3CGPA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 10:00:58 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:63546 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932896Ab3CGPA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 10:00:57 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so673012oag.16
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 07:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=zvKDOkFLcnwDyvqXhueT+xL3cCEa7q2a3rtBqpzMVDM=;
        b=c2T/BRlYD2HsNWwfhkBKn5HXkEfhvSTlai+WAwnN5wKKVlvkRahjhxy5QnRik3aLGj
         d/ptFsenpBqhAQD9Wti96CHtmOehoyDf12iN32xHwKtLC0lLLFBLJ/eKvxSmxN8tHt3z
         h/iW9G0ypz9+7bTlsBtDQTiMw/txFBIQYyY52oUrEK0H1yi8+PbC0MeT/q9B6w+90YLD
         Q7hqPefraOX8sHQQpQg9ZYFr7xCYHlc/LSV/5mgAbtrjDR+sh54mURzmXuTJPfjEhks+
         4XJ446ciZBIABHSx1C3NTeOUQKD4uIRrppd6Zg+YdbWZykX8ejUCPTpaAd4paMe7ZHOD
         K8fw==
X-Received: by 10.60.12.226 with SMTP id b2mr25453492oec.76.1362668456349;
 Thu, 07 Mar 2013 07:00:56 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Thu, 7 Mar 2013 07:00:56 -0800 (PST)
X-Originating-IP: [212.219.195.16]
In-Reply-To: <1721159119.197038.1362660611167.JavaMail.root@openwide.fr>
X-Gm-Message-State: ALoCoQm7pL08DylxO86d5UlAS3R2V8xljmrkMRKLWDG5ROF7JqPOg2vXIXPdmtFIf8moLs7i6Om3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217596>

On Thu, Mar 7, 2013 at 12:50 PM, Jeremy Rosen <jeremy.rosen@openwide.fr> wrote:
>> >>
>> >> Git subtree ignores tags from the remote repo.
>> >>
>> >
>> > is that a design decision or a case of "not implemented yet"
>>
>> I'm not sure. If you imported all the tags from all your subtrees
>> repos, you could easily end up with duplicate tags from different
>> repos. They could be namespaced, but there is no concept of namespace
>> in git-subtree. That even assumes that you can tag a subtree (I've
>> not
>> tried).
>>
>
> Ok, I can understand that you don't want to import tags for namespace reason, but in that case shouldn't
> git subtree add refuse to create a subtree when the tag isn't a commit

It shouldn't and tries not to, but is limited in it's ability to
identify if a refspec points to a commit or not in the remote repo.

> or if it allows it, what would be the gracefull way to handle that ?

I've posted a patch (which is pending a lot of other changes to
git-subtree that I'm corralling) that tries to prevent some obvious
errors in the refspec. But letting the git fetch used by git-subtree
add and git-subtree pull catch the error and report it may be the best
option.

> i'm quite new to git's internals, so I don't really know if/what the right approch would be.
>
> note that all those problems seems to disapear when squash is not used

I've never really tried using --squash, I don't see that it adds any
value for me.

-- 
Paul [W] Campbell
