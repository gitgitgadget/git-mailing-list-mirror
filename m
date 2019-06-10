Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F911F462
	for <e@80x24.org>; Mon, 10 Jun 2019 10:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389509AbfFJKpa (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 06:45:30 -0400
Received: from mout.web.de ([212.227.17.11]:54869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389430AbfFJKpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 06:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560163512;
        bh=vJOPCgG1m0H4IykLgUfZokZSswvphqSJzwh5Y0BRVyI=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=kNpq8FPRpZXbqsc93Lj57m3wCIcEGhf2/SrYNXsRYKaPxwT5iNT9vhXhSJFYPSo+B
         tUIPeL5emIMqBmUCJP1Gp4U2ij1MYzPeSleUPN44Q6X1xXPNlLa3OI34ltjADY+3YT
         BD3u8e1/wiz1z/I5p78Zn4zEP73dYBGTkdAmYlrc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mTI-1geArk1acO-00wX3P; Mon, 10
 Jun 2019 12:45:12 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
 <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
 <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
 <nycvar.QRO.7.76.6.1904291720120.45@tvgsbejvaqbjf.bet>
 <05e97774-5dd1-7224-940f-e50558118d93@web.de>
 <20190501181807.GC4109@sigill.intra.peff.net>
X-Mozilla-News-Host: news://nntp.public-inbox.org
Message-ID: <c00a062a-4f01-4754-3429-e7bb2a26aac1@web.de>
Date:   Mon, 10 Jun 2019 12:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190501181807.GC4109@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOtQ8wApfJnrV5q1pLkMLw6O1pCLKOE5wU4SO4vdJIJYAUpxuiL
 LpznOVfke9y9/R686yWz6IfUh7+oUi7Yz8dgidsPkCgNIqUR+EH0Bf/E61DLBTXUPB1jMxE
 CvoX5owRDKdSdj6TVgyvza2Tn9O+fgSPLBbkbTMzjJZ/0fYtA1O+2BOO5TsYs3481frk45z
 byZcEgcU2zTdUDm4fDgmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aJpRj5kB8zQ=:naFGiY/ZlSepxrdiouNNqo
 OD6BFW+d+h4yRTkHXF2/cnurl6i2AdhQejCdt+LVh2Oe73doARr6ZaWy4pdgXHZUKIA+wqJge
 b1h90bllvx0Au44XHUFIi2yN382GOYNuvzi0ZSV88NNGxUyNYjy3N3oZ0BX2nLSk6a5TrBuk4
 JM3Ybgr9Pl/Z61O8vwwHh5vRQyzTKzE5uXckULEcZp55YiTZEBqQY+9yXG4bpfW1QmqFH2o20
 0TdNTtcqYXpzB6TtntO2Jjf9CnCSzlsZmdklxBILhWT8CYnX0nu7x+ZueUzSuVk6IAlagWVJl
 GN4tsx+BCbEsLMRelE/IFvnODJUyjKxwPPzDcqiNi41TP7alW/swAukJjDCaVh/PQQc/v+oti
 KazBdumVloX4XZ2QgVk3CzQchuKQRzIRfHjrNyr87vlmHdciJEr2gOKCYDTkHPBVzdXQZWT6j
 uKkMaFTUn/fJ540uJJGIvysbPw/vvb5vOygu99JQGxC4hwEaQCyWmF4rSXPjwxzEZJ75vp98Z
 EhYp8GGLCWjPx1wcjBg2rHPz0qW4v5P3CGIoUk3dhfRSy/Pn+ZX5exHQeCjALIwFeDIzvkKp/
 O5v1Yo5C2NuYjBVzhdgvjP33zXTZxLaj02tQP/LZ7RtaAt9Gkt06g5m6RSAYPy1ktaUgxhUF7
 3a0Sa/Yti/eVnFb8dL/RrDs9holCErTPEKuM3d5MTocDWSXTxQ5FX3HX0L07KH7GdbO13FHRr
 PSzjl0EcsLdtlsxBo8S1n6FNKYy52Wpjm3J+8+8zHIabjy82m7BFRB+7eJrJ18OzLTVKn2wed
 EG1RI1NdzctgvqGvzhUXvGkuofFjAT5do/FnPFi3p8eptEGD063CwGe1lL8SSYR5b9P9xB7I3
 X8C5vCgHsPhiGAkvoTKMa4wuJcm9qVu22Er/8XeNO19vedA2iobuzUpJLPUQEFvvVZds/W3j5
 Uf9eh74vkPNdbhym+gItBGQT4py6nHvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.19 um 20:18 schrieb Jeff King:
> On Wed, May 01, 2019 at 07:45:05PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> But since the performance is still not quite on par with `gzip`, I wou=
ld
>>> actually rather not, and really, just punt on that one, stating that
>>> people interested in higher performance should use `pigz`.
>>
>> Here are my performance numbers for generating .tar.gz files again:

OK, tried one more version, with pthreads (patch at the end).  Also
redid all measurements for better comparability; everything is faster
now for some reason (perhaps due to a compiler update? clang version
7.0.1-8 now):

master, using gzip(1):
Benchmark #1: git archive --format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     15.697 s =C2=B1  0.246 s    [User: 19.213=
 s, System: 0.386 s]
  Range (min =E2=80=A6 max):   15.405 s =E2=80=A6 16.103 s    10 runs

using zlib sequentially:
Benchmark #1: git archive --format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     19.191 s =C2=B1  0.408 s    [User: 19.091=
 s, System: 0.100 s]
  Range (min =E2=80=A6 max):   18.802 s =E2=80=A6 19.877 s    10 runs

using a gzip-lookalike:
Benchmark #1: git archive --format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     16.289 s =C2=B1  0.218 s    [User: 19.485=
 s, System: 0.337 s]
  Range (min =E2=80=A6 max):   16.020 s =E2=80=A6 16.555 s    10 runs

using zlib with start_async:
Benchmark #1: git archive --format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     16.516 s =C2=B1  0.334 s    [User: 20.282=
 s, System: 0.383 s]
  Range (min =E2=80=A6 max):   16.166 s =E2=80=A6 17.283 s    10 runs

using zlib in a separate thread (that's the new one):
Benchmark #1: git archive --format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     16.310 s =C2=B1  0.237 s    [User: 20.075=
 s, System: 0.173 s]
  Range (min =E2=80=A6 max):   15.983 s =E2=80=A6 16.790 s    10 runs

> I think the start_async() one seems like a good option. It reclaims most
> of the (wall-clock) performance, isn't very much code, and doesn't leave
> any ugly user-visible traces.

The pthreads numbers look a bit better still.  The patch is huge though,
because it duplicates almost everything.  It was easier that way; a real
patch series would extract functions that can be used both with static
and allocated headers first, and keep everything in archive-tar.c.

> I'd be fine to see it come later, though, on top of the patches Dscho is
> sending. Even though changing to sequential zlib is technically a change
> in behavior, the existing behavior wasn't really planned. And given the
> wall-clock versus CPU time tradeoff, it's not entirely clear that one
> solution is better than the other.

The current behavior is not an accident; the synchronous method was
rejected in 2009 because it was slower [1].  Redid the measurements
with v1.6.5-rc0 and the old patch [2], but they would only compile with
gcc (Debian 8.3.0-6) for me, so it's not directly comparable to the
numbers above:

v1.6.5-rc0:
Benchmark #1: ../git/git-archive HEAD | gzip
  Time (mean =C2=B1 =CF=83):     16.051 s =C2=B1  0.486 s    [User: 19.514=
 s, System: 0.341 s]
  Range (min =E2=80=A6 max):   15.416 s =E2=80=A6 17.001 s    10 runs

v1.6.5-rc0 + [2]:
Benchmark #1: ../git/git-archive --format=3Dtar.gz HEAD
  Time (mean =C2=B1 =CF=83):     19.684 s =C2=B1  0.374 s    [User: 19.601=
 s, System: 0.060 s]
  Range (min =E2=80=A6 max):   19.082 s =E2=80=A6 20.177 s    10 runs

User time is still slightly higher, but the difference is in the noise.

[1] http://public-inbox.org/git/4AAAC8CE.8020302@lsrfire.ath.cx/
[2] http://public-inbox.org/git/4AA97B61.6030301@lsrfire.ath.cx/

>>> And who knows, maybe nobody will complain at all about the performance=
?
>>
>> Probably.  And popular tarballs would be cached anyway, I guess.
>
> At GitHub we certainly do cache the git-archive output. We'd also be
> just fine with the sequential solution. We generally turn down
> pack.threads to 1, and keep our CPUs busy by serving multiple users
> anyway.
>
> So whatever has the lowest overall CPU time is generally preferable, but
> the times are close enough that I don't think we'd care much either way
> (and it's probably not worth having a config option or similar).

Moving back to 2009 and reducing the number of utilized cores both feels
weird, but the sequential solution *is* the most obvious, easiest and
(by a narrow margin) lightest one if gzip(1) is not an option anymore.

Anyway, the threading patch:

=2D--
 Makefile      |   1 +
 archive-tar.c |  11 +-
 archive-tgz.c | 452 ++++++++++++++++++++++++++++++++++++++++++++++++++
 archive.h     |   4 +
 4 files changed, 465 insertions(+), 3 deletions(-)
 create mode 100644 archive-tgz.c

diff --git a/Makefile b/Makefile
index 8a7e235352..ed649ac18d 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -834,6 +834,7 @@ LIB_OBJS +=3D alloc.o
 LIB_OBJS +=3D apply.o
 LIB_OBJS +=3D archive.o
 LIB_OBJS +=3D archive-tar.o
+LIB_OBJS +=3D archive-tgz.o
 LIB_OBJS +=3D archive-zip.o
 LIB_OBJS +=3D argv-array.o
 LIB_OBJS +=3D attr.o
diff --git a/archive-tar.c b/archive-tar.c
index 3e53aac1e6..929eb58235 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -15,7 +15,9 @@
 static char block[BLOCKSIZE];
 static unsigned long offset;

-static int tar_umask =3D 002;
+int tar_umask =3D 002;
+
+static const char internal_gzip[] =3D "git archive gzip";

 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args);
@@ -445,6 +447,9 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 	if (!ar->data)
 		BUG("tar-filter archiver called with no filter defined");

+	if (!strcmp(ar->data, internal_gzip))
+		return write_tgz_archive(ar, args);
+
 	strbuf_addstr(&cmd, ar->data);
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
@@ -483,9 +488,9 @@ void init_tar_archiver(void)
 	int i;
 	register_archiver(&tar_archiver);

-	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tgz.command", internal_gzip, NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
-	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tar.gz.command", internal_gzip, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
 	git_config(git_tar_config, NULL);
 	for (i =3D 0; i < nr_tar_filters; i++) {
diff --git a/archive-tgz.c b/archive-tgz.c
new file mode 100644
index 0000000000..ae219e1cc0
=2D-- /dev/null
+++ b/archive-tgz.c
@@ -0,0 +1,452 @@
+#include "cache.h"
+#include "config.h"
+#include "tar.h"
+#include "archive.h"
+#include "object-store.h"
+#include "streaming.h"
+
+#define RECORDSIZE	(512)
+#define BLOCKSIZE	(RECORDSIZE * 20)
+
+static gzFile gzip;
+static size_t offset;
+
+/*
+ * This is the max value that a ustar size header can specify, as it is f=
ixed
+ * at 11 octal digits. POSIX specifies that we switch to extended headers=
 at
+ * this size.
+ *
+ * Likewise for the mtime (which happens to use a buffer of the same size=
).
+ */
+#if ULONG_MAX =3D=3D 0xFFFFFFFF
+#define USTAR_MAX_SIZE ULONG_MAX
+#else
+#define USTAR_MAX_SIZE 077777777777UL
+#endif
+#if TIME_MAX =3D=3D 0xFFFFFFFF
+#define USTAR_MAX_MTIME TIME_MAX
+#else
+#define USTAR_MAX_MTIME 077777777777ULL
+#endif
+
+static void tgz_write(const void *data, size_t size)
+{
+	const char *p =3D data;
+	while (size) {
+		size_t to_write =3D size;
+		if (to_write > UINT_MAX)
+			to_write =3D UINT_MAX;
+		if (gzwrite(gzip, p, to_write) !=3D to_write)
+			die(_("gzwrite failed"));
+		p +=3D to_write;
+		size -=3D to_write;
+		offset =3D (offset + to_write) % BLOCKSIZE;
+	}
+}
+
+static void tgz_finish_record(void)
+{
+	size_t tail =3D offset % RECORDSIZE;
+	if (tail) {
+		size_t to_seek =3D RECORDSIZE - tail;
+		if (gzseek(gzip, to_seek, SEEK_CUR) < 0)
+			die(_("gzseek failed"));
+		offset =3D (offset + to_seek) % BLOCKSIZE;
+	}
+}
+
+static void tgz_write_trailer(void)
+{
+	size_t to_seek =3D BLOCKSIZE - offset;
+	if (to_seek < 2 * RECORDSIZE)
+		to_seek +=3D BLOCKSIZE;
+	if (gzseek(gzip, to_seek, SEEK_CUR) < 0)
+		 die(_("gzseek failed"));
+	if (gzflush(gzip, Z_FINISH) !=3D Z_OK)
+		die(_("gzflush failed"));
+}
+
+struct work_item {
+	void *buffer;
+	size_t size;
+	int finish_record;
+};
+
+#define TODO_SIZE 64
+struct work_item todo[TODO_SIZE];
+static int todo_start;
+static int todo_end;
+static int todo_done;
+static int all_work_added;
+static pthread_mutex_t tar_mutex;
+static pthread_t thread;
+
+static void tar_lock(void)
+{
+	pthread_mutex_lock(&tar_mutex);
+}
+
+static void tar_unlock(void)
+{
+	pthread_mutex_unlock(&tar_mutex);
+}
+
+static pthread_cond_t cond_add;
+static pthread_cond_t cond_write;
+static pthread_cond_t cond_result;
+
+static void add_work(void *buffer, size_t size, int finish_record)
+{
+	tar_lock();
+
+	while ((todo_end + 1) % ARRAY_SIZE(todo) =3D=3D todo_done)
+		pthread_cond_wait(&cond_write, &tar_mutex);
+
+	todo[todo_end].buffer =3D buffer;
+	todo[todo_end].size =3D size;
+	todo[todo_end].finish_record =3D finish_record;
+
+	todo_end =3D (todo_end + 1) % ARRAY_SIZE(todo);
+
+	pthread_cond_signal(&cond_add);
+	tar_unlock();
+}
+
+static struct work_item *get_work(void)
+{
+	struct work_item *ret =3D NULL;
+
+	tar_lock();
+	while (todo_start =3D=3D todo_end && !all_work_added)
+		pthread_cond_wait(&cond_add, &tar_mutex);
+
+	if (todo_start !=3D todo_end || !all_work_added) {
+		ret =3D &todo[todo_start];
+		todo_start =3D (todo_start + 1) % ARRAY_SIZE(todo);
+	}
+	tar_unlock();
+	return ret;
+}
+
+static void work_done(void)
+{
+	tar_lock();
+	todo_done =3D (todo_done + 1) % ARRAY_SIZE(todo);
+	pthread_cond_signal(&cond_write);
+
+	if (all_work_added && todo_done =3D=3D todo_end)
+		pthread_cond_signal(&cond_result);
+	tar_unlock();
+}
+
+static void *run(void *arg)
+{
+	for (;;) {
+		struct work_item *w =3D get_work();
+		if (!w)
+			break;
+		tgz_write(w->buffer, w->size);
+		free(w->buffer);
+		if (w->finish_record)
+			tgz_finish_record();
+		work_done();
+	}
+	return NULL;
+}
+
+static void start_output_thread(void)
+{
+	int err;
+
+	pthread_mutex_init(&tar_mutex, NULL);
+	pthread_cond_init(&cond_add, NULL);
+	pthread_cond_init(&cond_write, NULL);
+	pthread_cond_init(&cond_result, NULL);
+
+	memset(todo, 0, sizeof(todo));
+
+	err =3D pthread_create(&thread, NULL, run, NULL);
+	if (err)
+		die(_("failed to create thread: %s"), strerror(err));
+}
+
+static void wait_for_output_thread(void)
+{
+	tar_lock();
+	all_work_added =3D 1;
+
+	while (todo_done !=3D todo_end)
+		pthread_cond_wait(&cond_result, &tar_mutex);
+
+	pthread_cond_broadcast(&cond_add);
+	tar_unlock();
+
+	pthread_join(thread, NULL);
+
+	pthread_mutex_destroy(&tar_mutex);
+	pthread_cond_destroy(&cond_add);
+	pthread_cond_destroy(&cond_write);
+	pthread_cond_destroy(&cond_result);
+}
+
+static int stream_blob(const struct object_id *oid)
+{
+	struct git_istream *st;
+	enum object_type type;
+	unsigned long sz;
+	ssize_t readlen;
+	size_t chunk_size =3D BLOCKSIZE * 10;
+
+	st =3D open_istream(oid, &type, &sz, NULL);
+	if (!st)
+		return error(_("cannot stream blob %s"), oid_to_hex(oid));
+	for (;;) {
+		char *buf =3D xmalloc(chunk_size);
+		readlen =3D read_istream(st, buf, chunk_size);
+		if (readlen <=3D 0)
+			break;
+		sz -=3D readlen;
+		add_work(buf, readlen, !sz);
+	}
+	close_istream(st);
+	return readlen;
+}
+
+/*
+ * pax extended header records have the format "%u %s=3D%s\n".  %u contai=
ns
+ * the size of the whole string (including the %u), the first %s is the
+ * keyword, the second one is the value.  This function constructs such a
+ * string and appends it to a struct strbuf.
+ */
+static void strbuf_append_ext_header(struct strbuf *sb, const char *keywo=
rd,
+				     const char *value, unsigned int valuelen)
+{
+	int len, tmp;
+
+	/* "%u %s=3D%s\n" */
+	len =3D 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
+	for (tmp =3D len; tmp > 9; tmp /=3D 10)
+		len++;
+
+	strbuf_grow(sb, len);
+	strbuf_addf(sb, "%u %s=3D", len, keyword);
+	strbuf_add(sb, value, valuelen);
+	strbuf_addch(sb, '\n');
+}
+
+/*
+ * Like strbuf_append_ext_header, but for numeric values.
+ */
+static void strbuf_append_ext_header_uint(struct strbuf *sb,
+					  const char *keyword,
+					  uintmax_t value)
+{
+	char buf[40]; /* big enough for 2^128 in decimal, plus NUL */
+	int len;
+
+	len =3D xsnprintf(buf, sizeof(buf), "%"PRIuMAX, value);
+	strbuf_append_ext_header(sb, keyword, buf, len);
+}
+
+static unsigned int ustar_header_chksum(const struct ustar_header *header=
)
+{
+	const unsigned char *p =3D (const unsigned char *)header;
+	unsigned int chksum =3D 0;
+	while (p < (const unsigned char *)header->chksum)
+		chksum +=3D *p++;
+	chksum +=3D sizeof(header->chksum) * ' ';
+	p +=3D sizeof(header->chksum);
+	while (p < (const unsigned char *)header + sizeof(struct ustar_header))
+		chksum +=3D *p++;
+	return chksum;
+}
+
+static size_t get_path_prefix(const char *path, size_t pathlen, size_t ma=
xlen)
+{
+	size_t i =3D pathlen;
+	if (i > 1 && path[i - 1] =3D=3D '/')
+		i--;
+	if (i > maxlen)
+		i =3D maxlen;
+	do {
+		i--;
+	} while (i > 0 && path[i] !=3D '/');
+	return i;
+}
+
+static void prepare_header(struct archiver_args *args,
+			   struct ustar_header *header,
+			   unsigned int mode, unsigned long size)
+{
+	xsnprintf(header->mode, sizeof(header->mode), "%07o", mode & 07777);
+	xsnprintf(header->size, sizeof(header->size), "%011"PRIoMAX , S_ISREG(mo=
de) ? (uintmax_t)size : (uintmax_t)0);
+	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned long=
) args->time);
+
+	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
+	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
+	strlcpy(header->uname, "root", sizeof(header->uname));
+	strlcpy(header->gname, "root", sizeof(header->gname));
+	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
+	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
+
+	memcpy(header->magic, "ustar", 6);
+	memcpy(header->version, "00", 2);
+
+	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_c=
hksum(header));
+}
+
+static void write_extended_header(struct archiver_args *args,
+				  const struct object_id *oid,
+				  struct strbuf *extended_header)
+{
+	size_t size;
+	char *buffer =3D strbuf_detach(extended_header, &size);
+	struct ustar_header *header =3D xcalloc(1, sizeof(*header));
+	unsigned int mode;
+	*header->typeflag =3D TYPEFLAG_EXT_HEADER;
+	mode =3D 0100666;
+	xsnprintf(header->name, sizeof(header->name), "%s.paxheader",
+		  oid_to_hex(oid));
+	prepare_header(args, header, mode, size);
+	add_work(header, sizeof(*header), 1);
+	add_work(buffer, size, 1);
+}
+
+static int write_tar_entry(struct archiver_args *args,
+			   const struct object_id *oid,
+			   const char *path, size_t pathlen,
+			   unsigned int mode)
+{
+	struct ustar_header *header =3D xcalloc(1, sizeof(*header));
+	struct strbuf ext_header =3D STRBUF_INIT;
+	unsigned int old_mode =3D mode;
+	unsigned long size, size_in_header;
+	void *buffer;
+	int err =3D 0;
+
+	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
+		*header->typeflag =3D TYPEFLAG_DIR;
+		mode =3D (mode | 0777) & ~tar_umask;
+	} else if (S_ISLNK(mode)) {
+		*header->typeflag =3D TYPEFLAG_LNK;
+		mode |=3D 0777;
+	} else if (S_ISREG(mode)) {
+		*header->typeflag =3D TYPEFLAG_REG;
+		mode =3D (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
+	} else {
+		return error(_("unsupported file mode: 0%o (SHA1: %s)"),
+			     mode, oid_to_hex(oid));
+	}
+	if (pathlen > sizeof(header->name)) {
+		size_t plen =3D get_path_prefix(path, pathlen,
+					      sizeof(header->prefix));
+		size_t rest =3D pathlen - plen - 1;
+		if (plen > 0 && rest <=3D sizeof(header->name)) {
+			memcpy(header->prefix, path, plen);
+			memcpy(header->name, path + plen + 1, rest);
+		} else {
+			xsnprintf(header->name, sizeof(header->name), "%s.data",
+				  oid_to_hex(oid));
+			strbuf_append_ext_header(&ext_header, "path",
+						 path, pathlen);
+		}
+	} else
+		memcpy(header->name, path, pathlen);
+
+	if (S_ISREG(mode) && !args->convert &&
+	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
+	    size > big_file_threshold)
+		buffer =3D NULL;
+	else if (S_ISLNK(mode) || S_ISREG(mode)) {
+		enum object_type type;
+		buffer =3D object_file_to_archive(args, path, oid, old_mode, &type, &si=
ze);
+		if (!buffer)
+			return error(_("cannot read %s"), oid_to_hex(oid));
+	} else {
+		buffer =3D NULL;
+		size =3D 0;
+	}
+
+	if (S_ISLNK(mode)) {
+		if (size > sizeof(header->linkname)) {
+			xsnprintf(header->linkname, sizeof(header->linkname),
+				  "see %s.paxheader", oid_to_hex(oid));
+			strbuf_append_ext_header(&ext_header, "linkpath",
+						 buffer, size);
+		} else
+			memcpy(header->linkname, buffer, size);
+	}
+
+	size_in_header =3D size;
+	if (S_ISREG(mode) && size > USTAR_MAX_SIZE) {
+		size_in_header =3D 0;
+		strbuf_append_ext_header_uint(&ext_header, "size", size);
+	}
+
+	prepare_header(args, header, mode, size_in_header);
+
+	if (ext_header.len > 0) {
+		write_extended_header(args, oid, &ext_header);
+	}
+	add_work(header, sizeof(*header), 1);
+	if (S_ISREG(mode) && size > 0) {
+		if (buffer)
+			add_work(buffer, size, 1);
+		else
+			err =3D stream_blob(oid);
+	} else
+		free(buffer);
+	return err;
+}
+
+static void write_global_extended_header(struct archiver_args *args)
+{
+	const struct object_id *oid =3D args->commit_oid;
+	struct strbuf ext_header =3D STRBUF_INIT;
+	struct ustar_header *header =3D xcalloc(1, sizeof(*header));
+	unsigned int mode;
+	size_t size;
+	char *buffer;
+
+	if (oid)
+		strbuf_append_ext_header(&ext_header, "comment",
+					 oid_to_hex(oid),
+					 the_hash_algo->hexsz);
+	if (args->time > USTAR_MAX_MTIME) {
+		strbuf_append_ext_header_uint(&ext_header, "mtime",
+					      args->time);
+		args->time =3D USTAR_MAX_MTIME;
+	}
+
+	if (!ext_header.len)
+		return;
+
+	buffer =3D strbuf_detach(&ext_header, &size);
+	*header->typeflag =3D TYPEFLAG_GLOBAL_HEADER;
+	mode =3D 0100666;
+	xsnprintf(header->name, sizeof(header->name), "pax_global_header");
+	prepare_header(args, header, mode, size);
+	add_work(header, sizeof(*header), 1);
+	add_work(buffer, size, 1);
+}
+
+int write_tgz_archive(const struct archiver *ar, struct archiver_args *ar=
gs)
+{
+	int level =3D args->compression_level;
+	int err =3D 0;
+
+	gzip =3D gzdopen(1, "wb");
+	if (!gzip)
+		return error(_("gzdopen failed"));
+	if (gzsetparams(gzip, level, Z_DEFAULT_STRATEGY) !=3D Z_OK)
+		return error(_("unable to set compression level %d"), level);
+
+	start_output_thread();
+	write_global_extended_header(args);
+	err =3D write_archive_entries(args, write_tar_entry);
+	if (err)
+		return err;
+	wait_for_output_thread();
+	tgz_write_trailer();
+	return err;
+}
diff --git a/archive.h b/archive.h
index e60e3dd31c..b00afa1a9f 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -45,6 +45,10 @@ void init_tar_archiver(void);
 void init_zip_archiver(void);
 void init_archivers(void);

+int tar_umask;
+
+int write_tgz_archive(const struct archiver *ar, struct archiver_args *ar=
gs);
+
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const struct object_id *oid,
 					const char *path, size_t pathlen,
=2D-
2.22.0
