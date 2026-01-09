Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16392DC34B
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989120; cv=none; b=EQWa3WsP/yTjXMnt46VwhrX0cQoXu/3xgaMktAyStSP7u/HQFYkmSWLto4v/kxn9kKPMUbM2iAsU2wm+IfyJ/LTCzjKe+i7A/m5mPAMlt04rImXLWWYQ9VfIGNWWf6roh4fOsc/HQJjiQDn54GKCX0Cd2OqlypndmmLK9+4pCM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989120; c=relaxed/simple;
	bh=AJ+GsV6ft7SAdTq1EA133zxKhb4FTNDZ6qZ5KpZ44vM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b5EMZGW7kEsfDhQdvOZ1RsGdJovkieBRa+uulgdQH39s45felovxX5aKGxHxl1yW67f3zowWPuWlvPHLX6WkqlYSFjA66VboIxi3T+jiiUv1oUmS5IkR4k9SB7f5KIOnektty55+oyqti2l2fZNYSwTTgQUbxhPX38Vct3Vcgfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HixIhQq+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HixIhQq+"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888546d570so56000256d6.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989117; x=1768593917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2lmR7RUy3qHuQWx1ImgadPIAAXEfgeTqXM4ufcc6cU=;
        b=HixIhQq+AAoYV7a3HNABJVaUt/B8WgVuL4bE3O34pqGTXAj7Uko/NR0g1y120wFX8Z
         xBgGmy0xDkfBr98/mYtMFRyOA83xG7uAI11KypyGbplIyvl+b39a3UsIruQuHjm14FJi
         4gILnZQoEZLBmgxHx761WbGDeEteUnE2AdUeWV1fcehQEaqxaOkXt3UI5Vt9OxVZmKHq
         UGd1+gP5p4+aMjlQMZIGFvhzhWvWJZIW51VN6bbbpFzEX8Vf9Q4O6PY0I3EcG0q1pk/n
         auHDxMxD147qyNMAuV8397xP7sQZpe9yklc8lzJVk+5HItcrqE0euhKK5chZXT7Hz+OF
         Xl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989117; x=1768593917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g2lmR7RUy3qHuQWx1ImgadPIAAXEfgeTqXM4ufcc6cU=;
        b=jjRoO+K1p5Oc02vQWAp0Vi65lJJiJljnPfUbzsP4UGkOp8CksrzGn78bpPrD6jmIYm
         ToJ7RVM7sHnx3uo16z2gt4ldRhkq+FjZoCoha2uWlQmEhYKbcl+lKkuiFIeqJGlrNxUJ
         KqYq3JBOrkRzozAIAkCXtmvH3oLoFA1nZa4Jj/uR/I1Q7g8WFGDiWz3DNHBpGsU5JLJS
         31dd2vc++t5ys79Do+itPBdCPZc0p7a/gTXwuwA12wVn7Qf0QC7yKjcvJ36vtgP37PzC
         5NRvpA4rsqU/JLD0IkpiNTA87/qDNASNUpQcZyGqNv0nnyN2EJt5lSVzD6fyah59bBCV
         ztIg==
X-Gm-Message-State: AOJu0YyRyET42z1ckqudRxBarx0TwW06eAuBNR6Lw9A+cW9M7repj5ey
	UJ3rVcFnvNJHQtB5YGhQdXG5tCJI6YstB/NK+WFMzkfWkp7KYB86DDySWzeGpqeY
X-Gm-Gg: AY/fxX7uZm+3N7i8T6fWmz3l+If2oTQpNlLvnv8/lhiESohVhYhnS41HYh6y8tjGzk7
	9J5OgSddgHIT9QwS+4KGXG+TwGfcDab6yhNFoziDyaYR27bNKO3FNnxes4s53gv8JKUV7LjUrO1
	HaBC6jPDNkX0BuVqO8Ly25WfD/SjFS66dp15ctFT+ejJFck9QyK4t7O9YhmT4PAokS2aYR70Wgh
	yLHHmw7bEnDCza3+yJwUbSHmUzRWP08I80GrTMhGfQxW3I+tMs8IIs3wQZN12nbNiaa/pWEHrlD
	UTuGJ1oh1u6b3OGcRfO9wcFqQUA/R9/ptDE1DEFhEsBoNkmpNeXGRBS0i4PFIEYt8rYV27LCLKn
	j6bO78QQeISiX0rW6urSd//wfekjmfMGccIjMb9T9f65blqsC0zCRunIHyZFt2SdkQFQBIt3X5O
	SO84oOcIG8Qm4F
X-Google-Smtp-Source: AGHT+IESXeZFjEZkjfDO+X837KqI/8vB8BYilfbLSq/VvJKiQ84AP8d5zT+Iha0qB5wbzzE9UTLshQ==
X-Received: by 2002:a05:6214:590f:b0:882:5124:24b2 with SMTP id 6a1803df08f44-8908424f654mr154767876d6.32.1767989116706;
        Fri, 09 Jan 2026 12:05:16 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e202esm79699096d6.14.2026.01.09.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:15 -0800 (PST)
Message-Id: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:04:57 +0000
Subject: [PATCH v2 00/18] Support symbolic links on Windows
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This finally upstreams Git for Windows' support for Windows' branch of
symbolic links, which has been maturing since 2015. It is based off of
js/prep-symlink-windows.

Changes since v1:

 * Changed Karsten's email address to the current one.
 * The changes to do_lstat() are now reflected by the comment preceding that
   function.
 * The commit message mentioning some ELOOP logic when symlink support is
   disabled, which had no corresponding part in the commit's diff, was
   adjusted to no longer mention that long gone change.
 * Fixed the typo "woutl".
 * Dropped a misleading, stale comment about ENOSYS in the readlink()
   implementation (talking about a long-dropped part of the original patch).

Bill Zissimopoulos (1):
  mingw: compute the correct size for symlinks in `mingw_lstat()`

Johannes Schindelin (3):
  mingw: try to create symlinks without elevated permissions
  mingw: emulate `stat()` a little more faithfully
  mingw: special-case index entries for symlinks with buggy size

Karsten Blees (14):
  mingw: don't call `GetFileAttributes()` twice in `mingw_lstat()`
  mingw: implement `stat()` with symlink support
  mingw: drop the separate `do_lstat()` function
  mingw: let `mingw_lstat()` error early upon problems with reparse
    points
  mingw: teach dirent about symlinks
  mingw: factor out the retry logic
  mingw: change default of `core.symlinks` to false
  mingw: add symlink-specific error codes
  mingw: handle symlinks to directories in `mingw_unlink()`
  mingw: support renaming symlinks
  mingw: allow `mingw_chdir()` to change to symlink-resolved directories
  mingw: implement `readlink()`
  mingw: implement basic `symlink()` functionality (file symlinks only)
  mingw: add support for symlinks to directories

 compat/mingw-posix.h  |   6 +-
 compat/mingw.c        | 635 ++++++++++++++++++++++++++++++++----------
 compat/win32.h        |   6 +-
 compat/win32/dirent.c |   5 +-
 read-cache.c          |  11 +
 5 files changed, 507 insertions(+), 156 deletions(-)


base-commit: 1887b3dd06823575e37ad19b5827d467e126c6ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2018%2Fdscho%2Fsymlinks-next-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2018/dscho/symlinks-next-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2018

Range-diff vs v1:

  1:  dae450dd0e !  1:  6ec4ff7457 mingw: don't call `GetFileAttributes()` twice in `mingw_lstat()`
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: don't call `GetFileAttributes()` twice in `mingw_lstat()`
     @@ Commit message
          free, and also have a (wide char) buffer that can be modified. This
          makes it easy to avoid that extraneous Win32 API call.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
     +@@ compat/mingw.c: static int has_valid_directory_prefix(wchar_t *wfilename)
     + }
     + 
     + /* We keep the do_lstat code in a separate function to avoid recursion.
     +- * When a path ends with a slash, the stat will fail with ENOENT. In
     +- * this case, we strip the trailing slashes and stat again.
     ++ * When a path ends with a slash, the call to `GetFileAttributedExW()`
     ++ * would fail. To prevent this, we strip any trailing slashes before that
     ++ * call.
     +  *
     +  * If follow is true then act like stat() and report on the link
     +  * target. Otherwise report on the link itself.
      @@ compat/mingw.c: static int do_lstat(int follow, const char *file_name, struct stat *buf)
       {
       	WIN32_FILE_ATTRIBUTE_DATA fdata;
  2:  c36848eda7 !  2:  5d83a8ab76 mingw: implement `stat()` with symlink support
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: implement `stat()` with symlink support
     @@ Commit message
          permissions, and then calling `GetFileInformationByHandle()` on it. This
          way, all links are resolved by the Windows file system layer.
      
     -    If symlinks are disabled, use `mingw_lstat()` as before, but fail with
     -    `ELOOP` if a symlink would have to be resolved.
     -
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
  3:  aa0ca80bbb !  3:  d3953f1826 mingw: drop the separate `do_lstat()` function
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: drop the separate `do_lstat()` function
     @@ Commit message
          the extra function and the old `mingw_stat()`-specific (`follow == 1`)
          logic.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
     @@ compat/mingw.c: static int has_valid_directory_prefix(wchar_t *wfilename)
       }
       
      -/* We keep the do_lstat code in a separate function to avoid recursion.
     -- * When a path ends with a slash, the stat will fail with ENOENT. In
     -- * this case, we strip the trailing slashes and stat again.
     +- * When a path ends with a slash, the call to `GetFileAttributedExW()`
     +- * would fail. To prevent this, we strip any trailing slashes before that
     +- * call.
      - *
      - * If follow is true then act like stat() and report on the link
      - * target. Otherwise report on the link itself.
  4:  886044373b !  4:  a6355789c3 mingw: let `mingw_lstat()` error early upon problems with reparse points
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: let `mingw_lstat()` error early upon problems with reparse points
     @@ Commit message
          `--color-moved -w`. That code was _not_ moved because a subsequent
          commit will move it to an altogether different function, anyway.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
  5:  db1d156aa0 !  5:  8b7f5a8fc7 mingw: teach dirent about symlinks
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: teach dirent about symlinks
     @@ Commit message
      
          Implement `DT_LNK` detection in dirent.c's `readdir()` function.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
  6:  4c49a3d9bf =  6:  1159e86dc4 mingw: compute the correct size for symlinks in `mingw_lstat()`
  7:  ad74d540f2 !  7:  4aeccd6656 mingw: factor out the retry logic
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: factor out the retry logic
     @@ Commit message
      
          In `mingw_rmdir()`, we include special error handling in the retry loop.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
  8:  25313cea76 !  8:  86c0742748 mingw: change default of `core.symlinks` to false
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: change default of `core.symlinks` to false
     @@ Commit message
          is true for the time being (an experiment to switch to BusyBox-w32
          failed due to the experimental nature of BusyBox-w32).
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
  9:  b698f4a002 !  9:  9a0093d34b mingw: add symlink-specific error codes
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: add symlink-specific error codes
     @@ Commit message
          Let's handle a couple of symlink-related error codes that will become
          relevant with the upcoming support for symlinks on Windows.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
 10:  282aba42e8 ! 10:  5dc90f9785 mingw: handle symlinks to directories in `mingw_unlink()`
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: handle symlinks to directories in `mingw_unlink()`
      
          The `_wunlink()` and `DeleteFileW()` functions refuse to delete symlinks
     -    to directories on Windows; The error code woutl be `ERROR_ACCESS_DENIED`
     +    to directories on Windows; The error code would be `ERROR_ACCESS_DENIED`
          in that case. Take that error code as an indicator that we need to try
          `_wrmdir()` as well. In the best case, it will remove a symlink. In the
          worst case, it will fail with the same error code again.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
 11:  5cb3b10500 ! 11:  3670a0a181 mingw: support renaming symlinks
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: support renaming symlinks
     @@ Commit message
          Avoid the `_wrename()` call, and go with directly calling
          `MoveFileEx()`, with proper error handling of course.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
 12:  49920839bb ! 12:  f79cf31dab mingw: allow `mingw_chdir()` to change to symlink-resolved directories
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: allow `mingw_chdir()` to change to symlink-resolved directories
     @@ Commit message
          Windows is limited to only MAX_PATH (260) characters. Therefore using
          symlinks and long paths in combination may be problematic.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
 13:  8fef8220f4 ! 13:  1ae9c63a89 mingw: implement `readlink()`
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: implement `readlink()`
     @@ Commit message
          Implement `readlink()` by reading NTFS reparse points via the
          `read_reparse_point()` function that was introduced earlier to determine
          the length of symlink targets. Works for symlinks and directory
     -    junctions. If symlinks are disabled, fail with `ENOSYS`.
     +    junctions.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw-posix.h ##
 14:  1dd5f9d6cd ! 14:  4e0ac43ef6 mingw: implement basic `symlink()` functionality (file symlinks only)
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: implement basic `symlink()` functionality (file symlinks only)
     @@ Commit message
          This implementation fails with `ENOSYS` if symlinks are disabled or
          unsupported.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw-posix.h ##
 15:  7b6dbc73f7 ! 15:  3d479fd47e mingw: add support for symlinks to directories
     @@
       ## Metadata ##
     -Author: Karsten Blees <blees@dcon.de>
     +Author: Karsten Blees <karsten.blees@gmail.com>
      
       ## Commit message ##
          mingw: add support for symlinks to directories
     @@ Commit message
          to directory or vice versa, or if the target directory is created in
          another process. It's the best Git can do, though.
      
     -    Signed-off-by: Karsten Blees <blees@dcon.de>
     +    Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/mingw.c ##
 16:  d3b89c29b0 = 16:  fb6aa461da mingw: try to create symlinks without elevated permissions
 17:  2e73ab4221 = 17:  40c3f7f36e mingw: emulate `stat()` a little more faithfully
 18:  817f488523 = 18:  afcf2bbfcb mingw: special-case index entries for symlinks with buggy size

-- 
gitgitgadget
