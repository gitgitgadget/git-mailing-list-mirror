Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC20E209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 16:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbdINQMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 12:12:52 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46082 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751392AbdINQMo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Sep 2017 12:12:44 -0400
X-AuditID: 12074412-1fdff7000000748d-49-59baaa7bcccf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A7.CE.29837.B7AAAB95; Thu, 14 Sep 2017 12:12:43 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCA7D.dip0.t-ipconnect.de [87.188.202.125])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8EGCeDZ009137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 14 Sep 2017 12:12:41 -0400
Subject: Re: [PATCH 00/20] Read `packed-refs` using mmap()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <ef919cc7-7e41-afb6-38b2-e2fae4efcbf1@alum.mit.edu>
Date:   Thu, 14 Sep 2017 18:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqFu9alekwY91GhZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLLqnvGW0+NHSw2yxeXM7iwOHx85Zd9k9PnyM81iwqdTjWe8eRo+L
        l5Q9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4tO0cS8EryYq/t56wNTC+Euxi5OSQEDCR2Pyli62L
        kYtDSGAHk0RXxxx2COcCk8TcB2fYQaqEBawknh9YAGaLCKhJTGw7xAJSxCxwl0li0ZLpzCAJ
        IQFzicY5OxlBbDYBXYlFPc1MIDavgL1E28fJQCs4OFgEVCWe/K4GCYsKREj0vb3MDlEiKHFy
        5hMWEJtTwEJi444nYGOYBdQl/sy7xAxhi0vcejKfCcKWl9j+dg7zBEaBWUjaZyFpmYWkZRaS
        lgWMLKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQuJDaAfj+pNyhxgFOBiV
        eHh39O6KFGJNLCuuzD3EKMnBpCTKu1d3Z6QQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEV7XiUDl
        vCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvOkrgRoFi1LTUyvSMnNK
        ENJMHJwgw3mAhnuD1PAWFyTmFmemQ+RPMSpKifP2rwBKCIAkMkrz4Hph6esVozjQK8K8SSDt
        PMDUB9f9CmgwE9DgM6d3gAwuSURISTUwLluwL5frfWx+rt/k3F8mPmaOhz/trTqjuaFLzrhp
        /wtVl+ZFcd6J731s3nroT5QPrfz5Rfyfw0YJZxWPWu2lCqclfzdGiLm0fewx07+59fOMqbWt
        knc3i9xXnevz4uXDPxsW3s3OX/S1RSJlsQzTuWUrjTc99b07M33t9LVTd089av1w7sHdUUos
        xRmJhlrMRcWJALq6oFI6AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/13/2017 07:15 PM, Michael Haggerty wrote:
> [...]
> * `mmap()` the whole file rather than `read()`ing it.
> [...]
Apparently this doesn't work on Windows, because the `snapshot` is
keeping the `packed-refs` file open too long, so the new file can't be
renamed on top of it.

I didn't realize that this is even allowed, but TIL that you can close a
file while keeping it mmapped. Does that technique work on Windows? If
so, I'll change v2 to do it as sketched below.

Michael

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 8235ac8506..95c1cd2a27 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -35,11 +35,8 @@ struct snapshot {
         */
        struct packed_ref_store *refs;

-       /*
-        * The file descriptor of the `packed-refs` file (open in
-        * read-only mode), or -1 if it is not open.
-        */
-       int fd;
+       /* Is the `packed-refs` file currently mmapped? */
+       int mmapped;

        /*
         * The contents of the `packed-refs` file. If the file was
@@ -135,12 +132,11 @@ static void acquire_snapshot(struct snapshot
*snapshot)
  */
 static void clear_snapshot_buffer(struct snapshot *snapshot)
 {
-       if (snapshot->fd >= 0) {
+       if (snapshot->mmapped) {
                if (munmap(snapshot->buf, snapshot->eof - snapshot->buf))
                        die_errno("error ummapping packed-refs file %s",
                                  snapshot->refs->path);
-               close(snapshot->fd);
-               snapshot->fd = -1;
+               snapshot->mmapped = 0;
        } else {
                free(snapshot->buf);
        }
@@ -525,6 +521,7 @@ static const char *find_reference_location(struct
snapshot *snapshot,
 static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 {
        struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
+       int fd;
        struct stat st;
        size_t size;
        int sorted = 0;
@@ -533,8 +530,8 @@ static struct snapshot *create_snapshot(struct
packed_ref_store *refs)
        acquire_snapshot(snapshot);
        snapshot->peeled = PEELED_NONE;

-       snapshot->fd = open(refs->path, O_RDONLY);
-       if (snapshot->fd < 0) {
+       fd = open(refs->path, O_RDONLY);
+       if (fd < 0) {
                if (errno == ENOENT) {
                        /*
                         * This is OK; it just means that no
@@ -549,15 +546,16 @@ static struct snapshot *create_snapshot(struct
packed_ref_store *refs)
                }
        }

-       stat_validity_update(&snapshot->validity, snapshot->fd);
+       stat_validity_update(&snapshot->validity, fd);

-       if (fstat(snapshot->fd, &st) < 0)
+       if (fstat(fd, &st) < 0)
                die_errno("couldn't stat %s", refs->path);

        size = xsize_t(st.st_size);
-       snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE,
-                             snapshot->fd, 0);
+       snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
        snapshot->eof = snapshot->buf + size;
+       snapshot->mmapped = 1;
+       close(fd);

        /* If the file has a header line, process it: */
        if (snapshot->buf < snapshot->eof && *snapshot->buf == '#') {
