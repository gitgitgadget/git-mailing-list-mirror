From: Andrey Kiyanovsky <andrey.kiyanovsky@gmail.com>
Subject: Git status reports untracked on tracked files
Date: Wed, 29 May 2013 11:40:56 +0300
Message-ID: <CAO-zUnh4018FSnsXzX4gLw-4AnWsKgEiZ5P4pktjxNokargQwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 10:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhbx2-0002Wi-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 10:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175Ab3E2Ilj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 04:41:39 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:50914 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965069Ab3E2Ilg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 04:41:36 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so23950828iec.22
        for <git@vger.kernel.org>; Wed, 29 May 2013 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=h1RYt+DnU7jOuOg4dd/I5JcmTYuem4kw+y8XD7AW5SI=;
        b=tsrHXh8Pnbjmya23sh+aXQCwlcfV7aKjfdgYy4IhswumLnM2cK//MUbxzgkj6OaGJu
         OqmAW1dKNnfPlteCR610MprYx+ymtW0vhstzfDaqxWVNMl04VOOGCbI34yblFXtCwwh2
         NzWsgN+sDj6AwTFtTyIryM2TQ2G1tWR4ChDJ4uz1AMiMRaZRTcQ/pveVoPgm8g8KmZac
         p09t8mXVWZJJQOxhd8wTthHqJO0GhfviYVSCdgLxAvbXGV7BijDoQbKV4pXXRKp7sbl4
         BGlDQo9RhCSwfaipC6U6uTYCjWi8ZeHNFoH0c/DXVV27onEGpVanljBTsSQAUcGpAPT3
         myOA==
X-Received: by 10.50.107.106 with SMTP id hb10mr9001574igb.25.1369816896276;
 Wed, 29 May 2013 01:41:36 -0700 (PDT)
Received: by 10.43.100.137 with HTTP; Wed, 29 May 2013 01:40:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225778>

I would be grateful for any thoughts about the follow problem.

Git status reports untracked files:

    $ git status
    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    # resource.enlighten/map/enlighten_test/.enlighten/__build_object__/geometry/land_9/processed/
    nothing added to commit but untracked files present (use "git add" to track)

But we have files at this directory at index:

    $ git ls-tree -r HEAD |grep land_9/processed/root.pim
    100644 blob 9eeca5c75dc2c945600b6e0d253a8cb8191b7e80
resource.enlighten/map/enlighten_test/.enlighten/__build_object__/geometry/land_9/processed/root.pim

I have checked this error appear after the first commit, that added this file.

I have tried:

1. Clone repo.
2. Clean/Checkout file (as described at this [1] article) - after
checkout status is untracked.
3. Copy full directory resource.enlighten/ to another repo and add
commit - no errors.
4. Run git fsck - no errors.

Git version 1.8.1.2. for Windows

Git config:

[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
	hideDotFiles = dotGitOnly
	compression = 1

Thank you in advance.

[1] http://stackoverflow.com/questions/11525358/git-untracked-files-list-is-wrong
