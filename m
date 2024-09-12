Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29691850AF
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158750; cv=none; b=QCUPeDKn4JvFds8uxqXh8jJl/95F7APMdCDAyqUJ5uq3olZXM3Im4167llGPVQ9TpG5/VIHHkWHYOSevLOYVAnkfOsFkhXHW3tl2ny+NbojE1THnquxuuikQKWsH+nNRxoUwMQ2nNWGAHH3kz4w318FUgAsvIi1S1ueDQGlQkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158750; c=relaxed/simple;
	bh=a8X+oVtrtbifd5XGeiqI1I9tO34NmK1SniMRkFErYDc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Jcmp4Gln3gN7vHxR+HQJiaeAScA154A4KOMvJod4qYhbkakBBBb2cf1ggODhqpP5NhWDMzwKlFd8LKB8ckJIveQDEOsyq+esbBkUVWh1MtngMp2k1UZze7iQ8utjy/F3oizaEWEC7CW7zX2ZHJcZl91W7nMo8MICY/yE6LvANp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK9r6sch; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK9r6sch"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cba8340beso14317545e9.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726158747; x=1726763547; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=87LGVFt6VmcQzmMb9ON0qQvryXtfmrbvt2ERGxZWKNE=;
        b=mK9r6schBurcTEWUQRExqd0jySftCYTvrUok54xrUQyp9NZ7WglmIeroAGBX/lmp3E
         VLJwLMoC6UfrUPUOe7wgxccMetuaqG+LPBuA0qknD4M6lTGKxPqkko1avfYvfvU7aM4t
         +WFlTvUfD5HNh7lY9riS2FRQtK65y8yHoGFmx1h7nb4XynNWLZ0/uf4xNU9VsTI792xz
         jPy0S2wz8UCeB8OQ1qhOHuICgtGroUjRHc6hleWe+Yj/48yi9PnLEgK4x06kJdqx/8/W
         FJITFZNCv61N89TF2PgQ/J4rkDl1eZDCOmOpxCGPY83fzZpkQXSy6eyz/1PThX4/+hkX
         5v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158747; x=1726763547;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87LGVFt6VmcQzmMb9ON0qQvryXtfmrbvt2ERGxZWKNE=;
        b=J27FBWwBndx5952oIWMgU8NP3VYuga5egNHtVzqufYr0g1rYS/cw6nS4mwFItl5LC9
         CKtO/rk8ZNAIjN8Drr30jUJHDt/T2zMzKcZvk0SlR7vbgaVW34h4GCYQVU1dAWgPrZMy
         a++Z6xH80+1MSaruRv5GlPNP2Rw9lARnaiXdEaJxFuL5Fx1EjTPlX8QV2KUliBHS9LEx
         nYe2xhqrD+fwMLNZLzWorwjIia740l1BTZCfBdjq2p6rVWr762TodlFs8hUnh2TK/gG3
         VcxOlFEPcZ0axS+GNGZunzIsmNItG6jjKShuwA60qziGyKefDfp0Mn9CLPmhNjBA+rQK
         kuCg==
X-Gm-Message-State: AOJu0Yy3Ba/6lMlELWwQkDNP/Phbvo25g2p4ZLYwmJcu8TOYOFPcj1sy
	LAktBTqjAQcTQdSfV1/1pvft0gx2JK73tMISNLlMdqdiDvtrw16coNZ07JEtIyIf7XNbDNAB4II
	lPMp3W5IN2nyZfuyJsMtnZZQRGuDAO2OI
X-Google-Smtp-Source: AGHT+IGAuVHJNJrVlLyWPcmGDAR33OuHUj6h3fd0PJX1QoA0I9UdawjDg+otHnqvvdJVwWCdoJTdEK90xaMY/hZV5XM=
X-Received: by 2002:a05:6000:1b86:b0:374:be11:22d7 with SMTP id
 ffacd0b85a97d-378c27a9120mr1947880f8f.13.1726158746066; Thu, 12 Sep 2024
 09:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rodrigo <rodrigolive@gmail.com>
Date: Thu, 12 Sep 2024 18:32:00 +0200
Message-ID: <CAGUZU_JZd_+8y19=kGif6u1+4n_+iOcVWV4p-kC0Uo=8Ev=aBA@mail.gmail.com>
Subject: Can't use bare repositories with Git.pm
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We're having an issue migrating from 2.31.1 to 2.46.0. The following
Perl code does not work in 2.46.0 as it did in 2.31.1 (tested linux
and darwin, did not check Windows):

    # test.pl
    use Git;
    my $repo = Git->repository( Directory => '/repo/bare.git' );
    my ($fh, $ctx) = $repo->command_output_pipe('rev-list', "2acf3456");
    print do { local $/; <$fh> };

Run:

   $ cd /home/rodrigo
   $ perl test.pl

Fails with the error:

    fatal: not a git repository: '/home/rodrigo'

If the repository it points to is a *bare repository* outside of the
current working directory, it only works if the directory is a child
directory to the bare (/repo/bare.git/info). The code above does work
for non-bare repos, and also works if we set `Repository =>
"/repo/bare.git"` instead of `Directory => ...`, but the Git.pm
documentation states `Directory => ...` should work for both bare and
non-bare alike, like it did in 2.31.1 (and other versions).

Bug hunting through the Git.pm code and skimming through the Git SCM
repo, there's a significant change (commit 20da61f25) that makes the
recent Git.pm rely on:

     git rev-parse --is-bare-repository --git-dir

for locating the correct (maybe a parent) repo directory. The change
was understandably done for security (and other many) reasons. It
started using --is-bare-repository to detect if it's a bare repository
we're dealing with, instead of relying on the old Git.pm redundant
code for bare repo detection, which was a sound decision. But some
crucial code was taken out.

Now if the directory path we're passing to `Directory => ...` is a
bare repo this new code will fail because git rev-parse --git-dir will
return a dot `.` (internally Git.pm will chdir() to the directory
before running git rev-parse, hence the result). The issue is that the
dot is now is being taken as is by Git.pm as the intended directory,
tricking it to think my cwd /home/rodrigo is the bare repository,
leading finally to the fatal error.

This could even become a security issue if the Perl program runs from
another working dir which happens to be a sensitive repo. Git.pm
commands would take action on the wrong repo. This hypothetical Perl
program, if run as, ie., a server program, could reveal / change
sensitive information from/on a server.

SOLUTION: I propose using "--absolute-git-dir" instead of "--git-dir":

    git rev-parse --is-bare-repository --absolute-git-dir

Which will replace the `.`  rev-parse response with a full path
resolved by git itself (and not Perl). This means the change to the
Perl code is minimal. I don't know if this will resolve all possible
cases, but it does fix our issue.

Here's a diff on my proposal -- sorry, noob in this neck of the woods,
didn't know if this is the correct way to contribute, but the change
is tiny and better if parsed by seasoned eyes anyway:

diff --git a/perl/Git.pm b/perl/Git.pm
index aebfe0c..63d0f92 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -187,7 +187,7 @@ sub repository {
                try {
                  # Note that "--is-bare-repository" must come first, as
                  # --git-dir output could contain newlines.
-                 $out = $search->command([qw(rev-parse
--is-bare-repository --git-dir)],
+                 $out = $search->command([qw(rev-parse
--is-bare-repository --absolute-git-dir)],
                                          STDERR => 0);
                } catch Git::Error::Command with {
                        throw Error::Simple("fatal: not a git
repository: $opts{Directory}");


thanks and best regards,
Rod
gihub.com/rodrigolive
