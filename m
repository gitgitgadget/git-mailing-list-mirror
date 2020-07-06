Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD9C433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 18:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDE32065F
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=anatoscope.com header.i=@anatoscope.com header.b="xYHtDVeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgGFSzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:55:39 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:56371 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgGFSzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 14:55:39 -0400
Date:   Mon, 06 Jul 2020 18:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anatoscope.com;
        s=protonmail; t=1594061737;
        bh=yl/Xyfd/YgrEuMbB1LlA9POTgwyoFip8nipCb9ZQ+2E=;
        h=Date:To:From:Reply-To:Subject:From;
        b=xYHtDVeN0Mmsk1wImOooPF8vN4QY+J7F6g5DEdTgfPudGsDglBvjrYt4ATLRkPtZ9
         qxz7r+Ux6TIv6wG2shRbn2BFNzZZt+PEmCEzRRxjWQgjKaMIN9Py0NvaxUpXAW6uew
         MyhOBfDQdBrRVJbeGf+zP+yTqZma8zfCj8UAPI1g=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Marc Legendre <legendre@anatoscope.com>
Reply-To: Marc Legendre <legendre@anatoscope.com>
Subject: Exit status of git show-ref --verify
Message-ID: <ggXIwBvE8oQXAL_579a2DJEsrEdPmMHoqEfSmQ31AlmZYRQ7AABmC-pMv1st9ljCXzfw__hnFbNvcBzEWbEfyr7mDSaFYuLv2NM03EDTlhk=@anatoscope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I stumbled upon a small discrepancy between the documentation of git-show-r=
ef
and its actual behavior. The documentation of the `--verify` flag of
git-show-ref says:

  "If nothing matches, 'git show-ref' will return an error code of 1"

Yet it seems to return 1 only if it is also called with --quiet. Tested wit=
h
the `next` branch:

  [~/dev/git] $ ./git show-ref --verify refs/heads/tagada
  fatal: 'refs/heads/tagada' - not a valid ref
  [~/dev/git] $ echo $?
  128

  [~/dev/git] $ ./git show-ref --quiet --verify refs/heads/tagada
  [~/dev/git] $ echo $?
  1


Regards,
Marc Legendre

