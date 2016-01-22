From: Duy Nguyen <pclouds@gmail.com>
Subject: Add post-worktree-add hook?
Date: Fri, 22 Jan 2016 16:45:49 +0700
Message-ID: <CACsJy8C9OELrkHZLzwoRx26AtzVvgouRA2+m0VH7GrJGSA8PCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 10:46:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMYIX-0006x1-09
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 10:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbcAVJqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 04:46:25 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33025 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbcAVJqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 04:46:21 -0500
Received: by mail-lb0-f173.google.com with SMTP id x4so38434116lbm.0
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 01:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=lGVZbCGAMya5PbzYAO6pmw2AaPyth1fN3vBcYXWZZSk=;
        b=V1InhuX+TddhdTO4Xit1c9jnV83V62fSrTGyZHWohdI6HYxbT7ET4RqWBUhO0c8wu/
         QYI+BqblouyK8hJaBQbuPzjkJArJNPhIXSLMDQ4RJ18BLgFVUf7fLkGCvQM0H7WxVSh7
         TxJca+E+teiBPwk+jFQlSVO248hdbnXzkvxLZpRJNbUGjJbnJig7PFO9RyUVHC6JHBzt
         90EpXBQWx2PvjJRIruSAotOGTXEf+OEcf1NkNkln/+qN18UTlvknZzmAZqQ9B2OdaZ/8
         UKnMa+4Jn4SrQrkPGGEPkwtMqNx0jmiBq6HhVh6RSEWIU/OUARwXqGtNZoqd4u+AJ4Gy
         QlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=lGVZbCGAMya5PbzYAO6pmw2AaPyth1fN3vBcYXWZZSk=;
        b=GQiy8Gsw5GnOuIxpS/1661voBEbk5UbqwTUwasJWfQbQcRFnTWkUyUwCWkX/oQmU1s
         uqVofOLF3XLM55K2K3tJIkijh3F0MP06MOqg8u+N+gD90i193HD7kBA9OqhA1v7Gj7Mv
         S8VApqWbffeNt6c2b5pPVqr06UD742UG/qzua6pRrX41339B1rJPYYzuI6BSuJS3rsby
         aXptYMo9J4pri1eojN5KED1uNkWRHN0AC5sJoR+v6izF//FxU7KOZE5dnf4bNyV4+lcz
         wMzekbjK61mWHazjtdES4k0sUTl/hJ2jwq75d5h5BlSIapB7uFfbkPi+eA1/d7GPkDzS
         b9FA==
X-Gm-Message-State: AG10YOTAezgVHa/FxB7h3A2xUAypwnh5y4nsClf0tuD1TYK2ThOTP6DNNOX7sb4o8Huja2joBAHSHB6XRGKgHA==
X-Received: by 10.112.149.230 with SMTP id ud6mr845265lbb.12.1453455979413;
 Fri, 22 Jan 2016 01:46:19 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 22 Jan 2016 01:45:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284555>

I started moving my git work space to multi-worktree and found it
annoying that every time I add a new worktree, my first step must be
copy my config.mak over. Room for improvement. I see three options:

1) add an option in 'worktree add' to copy all untracked files from
current worktree over

Only fits when you keep your .gitignore uptodate or we may copy a lot
of rubbish. Good for the lazies who don't want to write hooks though.

2) improve post-checkout hook, pass something else to indicate the
worktree add operation

We also pass the current working directory where 'worktree add' is
executed, so the user can copy selected files from the "source"
worktree if they want.

3) add a new post-worktree-add hook

Pretty much like 2 except that we separate the two. But I don't see
much point in adding this after reading that post-checkout hook is
also executed in git-clone.

Comments?
-- 
Duy
