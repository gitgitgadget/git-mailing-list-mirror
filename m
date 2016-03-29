From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/17] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 29 Mar 2016 09:31:39 +0700
Message-ID: <CACsJy8Bk19NNacDwez6BzicThnVUDQEoGe3m+ThiorP8uP9+eA@mail.gmail.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com> <1458349490-1704-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:32:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akjS6-0002yz-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 04:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbcC2CcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 22:32:14 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:32770 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcC2CcM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 22:32:12 -0400
Received: by mail-lf0-f45.google.com with SMTP id f67so1621976lfb.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+bvc7pcfXFtqhUbEjcHD0n49MIImFBt8G6qQqjQv2js=;
        b=gD8QU4+B2iLl86OPgIO1qxaPPmg+4Zx8vrWVBYxEBdQf7mPopjic1zcLR/VHMo6VJV
         IMrIjmVAduhzmX48I75pYiXYRFA4gU+ovr0c9TysHuK8pW2lTdumArICczyro0wvuJ9Z
         HGzFDI93TIiAXQmxMEu1FzBQRT7HwhEijn+NZfUSc4T5DoxvfW69AzDbYpO2eghuAz9M
         wnwGlPv/LMFkDm/APUKbSJnYJoJk6GR6CKzzNhQ0hfchv8t2KbcN1intkviwHna4/2xH
         cxkhhR3yIBg2Yni0nQ4z89BpDUiGGfo8i+msjQ2Bux963lCNqMbxsMGSiMAthwIOX856
         550Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+bvc7pcfXFtqhUbEjcHD0n49MIImFBt8G6qQqjQv2js=;
        b=MqjUjz6rssdCbAmYgD1oOi7H+/fz6enmQBbOrsXJ4s0angRPpv1Jfkh6xeZu8pCXqF
         57B0vuDekEd7/k5j+bqAzgCeDOPaQRaz4Mwhmz30hTyUk50LbuuZCFXo/UhnRGI9XLML
         FDyWpewHTJ5qel1hYcjaSGn3M+ZA+1zDUsDtLqqFtCOBOW1bgxh1JQ7vXjV5ZjpfIPMb
         IKFDUr7XU6uAeRraTtOZItooRqmH0XFNN524lgh9FnPv2hvuYYcFZsV8aqYycwa4j2xE
         r4olZEKPRee4yS3z0g7/fZq8MOj7d90Syug5zl4MUE+/kqVxoKX4wZtp4qpNugwGAXp8
         f5Ew==
X-Gm-Message-State: AD7BkJK83WdWH11HTlVpNUYZHC82uVSbnxP98/sDcdA63tfvLCwMtk2WxTuh3AOPBiMJ8sUZ8IGQRGGSOLvxVg==
X-Received: by 10.25.23.94 with SMTP id n91mr9078771lfi.3.1459218729773; Mon,
 28 Mar 2016 19:32:09 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 28 Mar 2016 19:31:39 -0700 (PDT)
In-Reply-To: <1458349490-1704-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290095>

On Sat, Mar 19, 2016 at 8:04 AM, David Turner <dturner@twopensource.com=
> wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> Instead of reading the index from disk and worrying about disk
> corruption, the index is cached in memory (memory bit-flips happen
> too, but hopefully less often). The result is faster read. Read time
> is reduced by 70%.
>
> The biggest gain is not having to verify the trailing SHA-1, which
> takes lots of time especially on large index files. But this also
> opens doors for further optimiztions:
>
>  - we could create an in-memory format that's essentially the memory
>    dump of the index to eliminate most of parsing/allocation
>    overhead. The mmap'd memory can be used straight away. Experiment
>    [1] shows we could reduce read time by 88%.

This reference [1] is missing (even in my old version). I believe it's
http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=3D2=
48771,
comparing 256.442ms in that mail with v4 number, 2245.113ms in 0/8
mail from the same thread.

> Git can poke the daemon via named pipes to tell it to refresh the
> index cache, or to keep it alive some more minutes. It can't give any
> real index data directly to the daemon. Real data goes to disk first,
> then the daemon reads and verifies it from there. Poking only happens
> for $GIT_DIR/index, not temporary index files.

I think we should go with unix socket on *nix platform instead of
named pipe. UNIX named pipe only allows one communication channel at a
time. Windows named pipe is different and allows multiple clients,
which is the same as unix socket.


> $GIT_DIR/index-helper.pipe is the named pipe for daemon process. The
> daemon reads from the pipe and executes commands.  Commands that need
> replies from the daemon will have to open their own pipe, since a
> named pipe should only have one reader.  Unix domain sockets don't
> have this problem, but are less portable.

Hm..NO_UNIX_SOCKETS is only set for Windows in config.mak.uname and
Windows will need to be specially tailored anyway, I think unix socket
would be more elegant.

> +static void share_index(struct index_state *istate, struct shm *is)
> +{
> +       void *new_mmap;
> +       if (istate->mmap_size <=3D 20 ||
> +           hashcmp(istate->sha1,
> +                   (unsigned char *)istate->mmap + istate->mmap_size=
 - 20) ||
> +           !hashcmp(istate->sha1, is->sha1) ||
> +           git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap=
_size,
> +                       &new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED=
,
> +                       "git-index-%s", sha1_to_hex(istate->sha1)) < =
0)
> +               return;
> +
> +       release_index_shm(is);
> +       is->size =3D istate->mmap_size;
> +       is->shm =3D new_mmap;
> +       hashcpy(is->sha1, istate->sha1);
> +       memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
> +
> +       /*
> +        * The trailing hash must be written last after everything is
> +        * written. It's the indication that the shared memory is now
> +        * ready.
> +        */
> +       hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, i=
s->sha1);

You commented here [1] a long time ago about memory barrier. I'm not
entirely sure if compilers dare to reorder function calls, but when
hashcpy is inlined and memcpy is builtin, I suppose that's possible...

[1] http://article.gmane.org/gmane.comp.version-control.git/280729

> +}
--=20
Duy
