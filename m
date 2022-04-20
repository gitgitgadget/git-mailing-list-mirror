Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A410FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354575AbiDTU3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353413AbiDTU33 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:29:29 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46C3B28C
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650486372;
        bh=NTZgeUtJbA6MatVn7JK1SkmHPDeXH1uOShOhnl6IWg0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=qo1XVtaux5Ou5FQ98j7aVriTTcEdS5dBoBgCivzy6fTcepbMJRxQsX2CdCsyBsRo5
         /Syeu+BPuBA2KqZGgXrGO68mPt3bls2djTsE7IUsSm2JP6wNyT70PxQS1FnC1SVPGQ
         hMg/+toXqXYa1+aHLGt85hq6TWQHIIFnimy1q4yo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14ta-1nsqhK0Qpe-012itZ; Wed, 20
 Apr 2022 22:26:12 +0200
Message-ID: <1c07dad1-3d3d-c52b-4440-631b46520254@web.de>
Date:   Wed, 20 Apr 2022 22:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] tempfile: add mks_tempfile_dt()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Fq418c5UxYw+50UbKstsHjdHRx7IqkaKJMfUgo3UEdlC0wvzUY
 P6vs0nQQwAvdMcyhv+VpPQKJAjDcKgQptmoKEEFmePJxE4cWYUqOViOT9ayKSIwjnw9shoo
 KvQyZZfbL4RQjS31tHRJSPRUoazHdTKQc33YOGm2DTca+oPKeYbhPi2xxOpmuDpjMq068hF
 k/4ow72+YuGhJQ5ePFzwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jqqa8E5LuL4=:jjshIxLy5lkvjQxRMPdAky
 iw0bIkr7BLu56aZTSNORrYlvC8wG0mp8LVKLEB+//1x667kAUwCOR+aN29LwxUkGXJf5Q7yu7
 mDRnRxGHdbOzmeL9ny1hMiLz9IlWOAuODw1VyDqPIFoR9vtFnLXyaErWv7U56suhaY2jbUV7p
 11PIZEYL5NtlyYpR7Ws5pptthMQh7kJMK8ieIBtVhf78hMBq+HuLJduG3U08SHOJ3cjztmVz0
 kSGJG++Ia/mWgZ5ZcKW9hu52zoqxjDXsPwogl8qyOX3ZwjxkInF7tWqRVr0pX3otwjmQwR4AN
 qr0cujAzjUt78Guy4UTAN2LrFWq9nc1PriAEQZ1tAuo9g3d0Ha9VA8psKQf//vozUPkDi/Hps
 ibkwOtOVIjviCwDpgd14fuXNkgt+AsMKxDU40LZp1QQBl45wrCLFyCe6LtlvsD+kqjaSWGZTI
 ajV0CN0x5k91r5gorn9hYK0WLN16RgzkQYLb6Kzpb+1arH+6P9oT0vz8P0IB5lvQh7fcY34K4
 vX0gnCzbR1vp7a0ICv5DQjecQv7jGKYcJ6bgBhtVBoOU7M4dgYv3w+chQrGzBZ2i27uyUpMZC
 WWKqPm0iTJ6J6DjWBmzqLXohhKbaNVUrbAFhpdjd8gOC8Ql7rF3/uEIqYGKkVzi7qoHPDKQ42
 b6wftllA0pW6UxDFPpnZZaCW1RN/chKq9GWFjsvgS04+3Ckpl45kZimMZueNQLuKKIaOscIih
 m0dCUnBfXUYRHizMMEIeo5jx/kkBYt/4QtMS5T6K0AADT8w03SuCLCoNx+IwgIgTRQXlxwtNB
 qi+So53+3Sq7mQ0QrkPeqEAp7g8t8ROb68cKqGKDLXZ6mWAtTCHSkbZW/cbpVlqY3e7Qdq0h0
 EMmhd0Hyo6MrhhcFXd+9Lvy7bRHERYiEwms6MueHI1J72a9ur3OZ7nPFReb2YjDvjFVig5uYY
 8KqYKNJZmYGZVkoEBHvYD/v6Hvk4bs1zxcTnR/OMOpZV7v2pq15QBLNITr/Cbzn1plOURdYyu
 v5zoVZQ+qwt8/EGPuZg4nN6J+dX2K2mqqSG7b9P2SBfRtI0iymiQaM2cyCSVxegKAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function to create a temporary file with a certain name in a
temporary directory created using mkdtemp(3).  Its result is more
sightly than the paths created by mks_tempfile_ts(), which include
a random prefix.  That's useful for files passed to a program that
displays their name, e.g. an external diff tool.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tempfile.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tempfile.h | 13 +++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tempfile.c b/tempfile.c
index 94aa18f3f7..2024c82691 100644
=2D-- a/tempfile.c
+++ b/tempfile.c
@@ -56,6 +56,20 @@

 static VOLATILE_LIST_HEAD(tempfile_list);

+static void remove_template_directory(struct tempfile *tempfile,
+				      int in_signal_handler)
+{
+	if (tempfile->directorylen > 0 &&
+	    tempfile->directorylen < tempfile->filename.len &&
+	    tempfile->filename.buf[tempfile->directorylen] =3D=3D '/') {
+		strbuf_setlen(&tempfile->filename, tempfile->directorylen);
+		if (in_signal_handler)
+			rmdir(tempfile->filename.buf);
+		else
+			rmdir_or_warn(tempfile->filename.buf);
+	}
+}
+
 static void remove_tempfiles(int in_signal_handler)
 {
 	pid_t me =3D getpid();
@@ -74,6 +88,7 @@ static void remove_tempfiles(int in_signal_handler)
 			unlink(p->filename.buf);
 		else
 			unlink_or_warn(p->filename.buf);
+		remove_template_directory(p, in_signal_handler);

 		p->active =3D 0;
 	}
@@ -100,6 +115,7 @@ static struct tempfile *new_tempfile(void)
 	tempfile->owner =3D 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
+	tempfile->directorylen =3D 0;
 	return tempfile;
 }

@@ -198,6 +214,52 @@ struct tempfile *mks_tempfile_tsm(const char *filenam=
e_template, int suffixlen,
 	return tempfile;
 }

+struct tempfile *mks_tempfile_dt(const char *directory_template,
+				 const char *filename)
+{
+	struct tempfile *tempfile;
+	const char *tmpdir;
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+	size_t directorylen;
+
+	if (!ends_with(directory_template, "XXXXXX")) {
+		errno =3D EINVAL;
+		return NULL;
+	}
+
+	tmpdir =3D getenv("TMPDIR");
+	if (!tmpdir)
+		tmpdir =3D "/tmp";
+
+	strbuf_addf(&sb, "%s/%s", tmpdir, directory_template);
+	directorylen =3D sb.len;
+	if (!mkdtemp(sb.buf)) {
+		int orig_errno =3D errno;
+		strbuf_release(&sb);
+		errno =3D orig_errno;
+		return NULL;
+	}
+
+	strbuf_addf(&sb, "/%s", filename);
+	fd =3D open(sb.buf, O_CREAT | O_EXCL | O_RDWR, 0600);
+	if (fd < 0) {
+		int orig_errno =3D errno;
+		strbuf_setlen(&sb, directorylen);
+		rmdir(sb.buf);
+		strbuf_release(&sb);
+		errno =3D orig_errno;
+		return NULL;
+	}
+
+	tempfile =3D new_tempfile();
+	strbuf_swap(&tempfile->filename, &sb);
+	tempfile->directorylen =3D directorylen;
+	tempfile->fd =3D fd;
+	activate_tempfile(tempfile);
+	return tempfile;
+}
+
 struct tempfile *xmks_tempfile_m(const char *filename_template, int mode)
 {
 	struct tempfile *tempfile;
@@ -316,6 +378,7 @@ void delete_tempfile(struct tempfile **tempfile_p)

 	close_tempfile_gently(tempfile);
 	unlink_or_warn(tempfile->filename.buf);
+	remove_template_directory(tempfile, 0);
 	deactivate_tempfile(tempfile);
 	*tempfile_p =3D NULL;
 }
diff --git a/tempfile.h b/tempfile.h
index 4de3bc77d2..d7804a214a 100644
=2D-- a/tempfile.h
+++ b/tempfile.h
@@ -82,6 +82,7 @@ struct tempfile {
 	FILE *volatile fp;
 	volatile pid_t owner;
 	struct strbuf filename;
+	size_t directorylen;
 };

 /*
@@ -198,6 +199,18 @@ static inline struct tempfile *xmks_tempfile(const ch=
ar *filename_template)
 	return xmks_tempfile_m(filename_template, 0600);
 }

+/*
+ * Attempt to create a temporary directory in $TMPDIR and to create and
+ * open a file in that new directory. Derive the directory name from the
+ * template in the manner of mkdtemp(). Arrange for directory and file
+ * to be deleted if the program exits before they are deleted
+ * explicitly. On success return a tempfile whose "filename" member
+ * contains the full path of the file and its "fd" member is open for
+ * writing the file. On error return NULL and set errno appropriately.
+ */
+struct tempfile *mks_tempfile_dt(const char *directory_template,
+				 const char *filename);
+
 /*
  * Associate a stdio stream with the temporary file (which must still
  * be open). Return `NULL` (*without* deleting the file) on error. The
=2D-
2.35.3
