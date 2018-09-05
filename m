Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394CC1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeIEVeQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:34:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:46084 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726335AbeIEVeQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 17:34:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85H2Yh0010694;
        Wed, 5 Sep 2018 10:03:11 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2m7qnmqd2a-1;
        Wed, 05 Sep 2018 10:03:10 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A3F8622E02A0;
        Wed,  5 Sep 2018 10:03:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 0F8F42CDEA7;
        Wed,  5 Sep 2018 10:03:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-recursive: remove superfluous semicolon
Date:   Wed,  5 Sep 2018 10:03:07 -0700
Message-Id: <20180905170308.32017-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.2.g1aedc61e22
In-Reply-To: <CACsJy8Cf5+3+6yDwe4Y4wYLze4Y6naW-pj134KTpXM+wyWbFVQ@mail.gmail.com>
References: <CACsJy8Cf5+3+6yDwe4Y4wYLze4Y6naW-pj134KTpXM+wyWbFVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050171
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 9:55 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Sep 5, 2018 at 6:49 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > Once I saw it, I couldn't unsee it, and it quickly started getting on=
 my
> > nerves...
>
> Bad Elijah! Should have grepped and fixed all three ;-)
>
> $ git grep ';;$' -- '*.c'
> builtin/receive-pack.c: hmac_sha1(sha1, buf.buf, buf.len,
> cert_nonce_seed, strlen(cert_nonce_seed));;
> merge-recursive.c:      struct dir_rename_entry *entry =3D NULL;;
> remote-curl.c:          options.filter =3D xstrdup(value);;

Whoops, indeed.  I didn't think about the fact that the same problem
might appear in some other file.  Anyway, here's the extended fix.

-- 8< --
Subject: [PATCH] Remove superfluous trailing semicolons

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/receive-pack.c | 2 +-
 merge-recursive.c      | 2 +-
 remote-curl.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c17ce94e12..a8423a940f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -465,7 +465,7 @@ static char *prepare_push_cert_nonce(const char *path=
, timestamp_t stamp)
 	unsigned char sha1[GIT_SHA1_RAWSZ];
=20
 	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
-	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_se=
ed));;
+	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_se=
ed));
 	strbuf_release(&buf);
=20
 	/* RFC 2104 5. HMAC-SHA1-80 */
diff --git a/merge-recursive.c b/merge-recursive.c
index e5243dbc54..1b5c255918 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2239,7 +2239,7 @@ static struct dir_rename_entry *check_dir_renamed(c=
onst char *path,
 {
 	char *temp =3D xstrdup(path);
 	char *end;
-	struct dir_rename_entry *entry =3D NULL;;
+	struct dir_rename_entry *entry =3D NULL;
=20
 	while ((end =3D strrchr(temp, '/'))) {
 		*end =3D '\0';
diff --git a/remote-curl.c b/remote-curl.c
index fb28309e85..762a55a75f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -178,7 +178,7 @@ static int set_option(const char *name, const char *v=
alue)
 		options.no_dependents =3D 1;
 		return 0;
 	} else if (!strcmp(name, "filter")) {
-		options.filter =3D xstrdup(value);;
+		options.filter =3D xstrdup(value);
 		return 0;
 	} else {
 		return 1 /* unsupported */;
--=20
2.19.0.rc2.2.g1aedc61e22

