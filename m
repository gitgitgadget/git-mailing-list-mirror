Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8F3C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 13:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiHFNoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHFNoD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 09:44:03 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E8101E0
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 06:44:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 96D1D32002E2
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 09:43:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 06 Aug 2022 09:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=masklinn.net; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659793439; x=1659879839; bh=WrJBvLa7sT
        bySNTUJ1lefRG0PXB7DeolBKC/Ed1DW/s=; b=LinANdeR0OZwy09k19Kj+kpDzP
        msR0YTQ0VGtGl1JRP6hpLe2UptZLH7DUrtIiGpXk5Kv7lFUCIcmD0J8zW+z80j3F
        cf5YQZU6+NJ46VV4voyy1PnOV56kYgi6LfNxZp+wRLIIsn32aEQ16/4Q0UDT0qcK
        vTwKxPOYrQZayViPed1u/CAI1WZlB/FS5TpGmg7kWjDj+aMaldC+xN+WU8818n+y
        Rku+hypmgE5KLVjS9bRuQJxqrHQ8agPxLRqH0YyGE5AgZC5RmExW0hxH4Kw2ARr9
        mNYotb3Ig6tCG6rqDcRpcaX4XAwzJ9/pS00iiSdxV9o1maq6RRgHxVgDhlmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659793439; x=1659879839; bh=WrJBvLa7sTbySNTUJ1lefRG0PXB7
        DeolBKC/Ed1DW/s=; b=Td7XrUZ4G8ud6L9dmCoD64Mc4I9C+t5l7nsNDlExtXKW
        xnsv3zd5pv+e9q/GcMnI9+qI7y9JOMmvgo7NfgkWrrd6kwCKARqHxux/ufuF36n2
        bSNGCBCRmfJp7LysS8VqP9OmFaBj56OG/wLfTn/iu7BGHqMFXygyCaqVHNuVgfnk
        yKSkxZp6iZOBohu2MxDEhm4i6NUz2i+o697qOV0sHOwgpxnkDViRLvtyF1qzsebQ
        WyD0qr/qzaf4E7WLwsUTANLHW7q+pPVYJA50u4ZN2Z9tYrTSHhVypMEiIbCO1d4l
        qkpd7s+zkvexY5xFwVBzzoYQyUODn+GHYmfgbQDdRA==
X-ME-Sender: <xms:HnDuYgkFUp3P4-nHeONbET_ICfnG7fcYhx-eTp1jSrRb_S03avWKAg>
    <xme:HnDuYv1WtGbkCVK94slN8NJR7_mIkhtcvRbNquhauT15BVPohVYYXK0pJ1XtxdXd9
    GlnY8RQKTNwi1_7etY>
X-ME-Received: <xmr:HnDuYuqvjE_jHNNbZp-zLPLLCI9dLdJsCv3zI79v76LlYu40LGazXRd5vCvi8CX7OgF1kGHFNU1iHk56Gq7n-p-meLAvdwx-UmcVhhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeffedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtjehmtd
    hhtddvnecuhfhrohhmpegirghvihgvrhcuofhorhgvlhcuoeigrghvihgvrhdrmhhorhgv
    lhesmhgrshhklhhinhhnrdhnvghtqeenucggtffrrghtthgvrhhnpefhuedtvedtffdtje
    euvdfhheffhffggeekfeeiheehudffteethfejteeukeelueenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeigrghvihgvrhdrmhhorhgvlhesmh
    grshhklhhinhhnrdhnvght
X-ME-Proxy: <xmx:H3DuYsmOjqEH3Y3YL2zUlunINoSey51Jc1F1P3WHHo1e5raX5qbhvA>
    <xmx:H3DuYu0liwmJ8yfQgXUQ3XMS6-y0SVhq_527h_ZhlLoUz565f0RkZg>
    <xmx:H3DuYjuwtBG-rhOihBWUlnnoXsKgZgt3NqoMrKfMoA1Vbc_P_9yeZg>
    <xmx:H3DuYniMm2QMGp7dagMTj_R89u-lXt0PSaeMHF3Rok3rmimIvhnJQg>
Feedback-ID: i3619468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sat, 6 Aug 2022 09:43:58 -0400 (EDT)
From:   Xavier Morel <xavier.morel@masklinn.net>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: fsck: BAD_FILEMODE diagnostic broken / never triggers
Message-Id: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
Date:   Sat, 6 Aug 2022 15:43:56 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at git's handling of invalid objects, I stumbled upon
git apparently not caring much about file mode values, except for the
following requirements:

- must be non-empty (badTree)
- must be octal (badTree)
- should not be zero-padded (zeroPaddedFilemode)

Looking at tree-walk this is obvious from decode_tree_entry: it calls
canon_mode, which

- checks the S_IFMT exactly, and falls back on 160000 (S_IFGITLINK)
  for cases other than S_ISREG, S_ISLNK, or S_ISDIR
- returns the corresponding S_IF (with the access modes unset) for all 
  cases other than S_ISREG, for which it returns 755 if S_IXUSR is set,
  otherwise 644

However looking at fsck_tree, it does have a fair amount of code to
validate entry modes and a dedicated message id for this (BAD_FILEMODE
/ badFilemode), it even has a code path for legacy entries with
S_IWGRP set (extensively documented under `git fsck --strict`).

I guess, over time mode canonicalisation has slowly creeped earlier
the tree-parsing code, and (seemingly for several years) it has been
occurring before "git fsck" gets tree entry information, so git fsck
simply can not see invalid entry modes?

Reproduction:

- create an empty git repository
- create tree for (or with) any possible entry type value
- run `git fsck --strict --no-dangling`

Expected:

all the trees except the 5 with valid filemodes should be flagged

Observed:

> git fsck --strict --no-dangling
Checking object directories: 100% (256/256), done.
notice: HEAD points to an unborn branch (master)
notice: No default references

Script to generate one tree for each filemode between 1 and 777777
(inclusive), can be run from a (non-bare) repository root, beware that
the resulting repository takes about 1GB.


from hashlib import sha1
from pathlib import Path
from zlib import compress

def hash_object(type, content):
    obj = b"%s %d\0%s" % (type.encode(), len(content), content)
    oid = sha1(obj).hexdigest()

    e_dir = GIT_ROOT / 'objects' / oid[:2]
    e_dir.mkdir(exist_ok=True, parents=True)

    e = e_dir / oid[2:]
    if not e.exists():
        e.write_bytes(compress(obj))

    return oid

# technically S_IFMT caps out at 200_000 - 1, but get_mode doesn't
# actually have a limit
MAX_ENTRY = 0o777_777
if __name__ == '__main__':
    GIT_ROOT = Path.cwd() / '.git'
    assert GIT_ROOT.is_dir()
    
    blob_hex = hash_object('blob', b"")
    blob_oid = bytes.fromhex(blob_hex)
    print("empty blob", blob_hex)

    tree_hex = hash_object("tree", b"100644 empty_blob\0" + blob_oid)
    tree_oid = bytes.fromhex(tree_hex)
    print("base tree", tree_hex)

    for mode in range(1, MAX_ENTRY+1):
        print(f"\r{mode:06o}/{MAX_ENTRY:o}", end=' ')
        tree = b"%o x\0%s" % (
            mode,
            tree_oid if (mode & 0o170_000) == 0o040_000 else blob_oid,
        )
        h = hash_object("tree", tree)
        print("=", h, end='', flush=True)

