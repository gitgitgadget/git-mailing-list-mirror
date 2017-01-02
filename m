Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CEB6205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbdABPHb (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:07:31 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53906 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755406AbdABPHa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Jan 2017 10:07:30 -0500
X-AuditID: 1207440d-8cfff700000009ba-4c-586a6ca53334
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 34.7D.02490.5AC6A685; Mon,  2 Jan 2017 10:07:18 -0500 (EST)
Received: from [192.168.69.190] (p5B10411C.dip0.t-ipconnect.de [91.16.65.28])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v02F7GKY029986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 2 Jan 2017 10:07:17 -0500
Subject: Re: [PATCH 13/17] refs: convert each_reflog_ent_fn to struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-14-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <49fcccfa-df28-c01b-0e51-1451ecf8e784@alum.mit.edu>
Date:   Mon, 2 Jan 2017 16:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170101191847.564741-14-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqLssJyvCYNd1douuK91MFj9aepgt
        2mb+YHJg9lh+8y+Tx7PePYwenzfJBTBHcdmkpOZklqUW6dslcGVs7PjMVnBaqqLhAlsD40aR
        LkZODgkBE4k1R7+wdDFycQgJXGaU+PppH5Rzhkli5ZZDjCBVwgKBEi/e72MDsUUEvCTmP5rB
        2sXIAVRUI9Hz2wQkzCwgK7F+xV+wcjYBXYlFPc1MICW8AvYSz7dngIRZBFQkJu2dBzZFVCBE
        4vKco2A2r4CgxMmZT1hAbE4BF4kvMw6yQYzUk9hx/RcrhC0vsf3tHOYJjPyzkLTMQlI2C0nZ
        AkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxgh4cm7g/H/OplDjAIcjEo8
        vB1RWRFCrIllxZW5hxglOZiURHkTNmRECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhDcoEKudN
        SaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfC2ZwM1ChalpqdWpGXmlCCk
        mTg4QYbzAA2XzwEZXlyQmFucmQ6RP8WoKCXOuyQLKCEAksgozYPrhaWPV4ziQK8I83aCrOAB
        ph647ldAg5mABn+NSwcZXJKIkJJqYJR6YqdoMXuiftXauYoHs8tnGImxfG0Ofi3P/pZj7YPZ
        +tsW/lyaeGdyYlbS8vYtjXcve06OMlpgMTd8yxf9CtOTAcLaRSw1U1SvxO84oPr5KLvO/Hsd
        Xq+/zmtdsLRkT4Rp0qJX57+c99NeF8f6xXry3OPGh+0fOTZ76svoVq7xEv0cap+jfkmJpTgj
        0VCLuag4EQCxRsmW+gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 08:18 PM, brian m. carlson wrote:
> Make each_reflog_ent_fn take two struct object_id pointers instead of
> two pointers to unsigned char.  Convert the various callbacks to use
> struct object_id as well.  Also, rename fsck_handle_reflog_sha1 to
> fsck_handle_reflog_oid.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/fsck.c       | 16 ++++++++--------
>  builtin/merge-base.c |  6 +++---
>  builtin/reflog.c     |  2 +-
>  reflog-walk.c        |  6 +++---
>  refs.c               | 24 ++++++++++++------------
>  refs.h               |  2 +-
>  refs/files-backend.c | 24 ++++++++++++------------
>  revision.c           | 12 ++++++------
>  sha1_name.c          |  2 +-
>  wt-status.c          |  6 +++---
>  10 files changed, 50 insertions(+), 50 deletions(-)
> 
> [...]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f9023939d..3da3141ee 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3113,15 +3113,15 @@ static int files_delete_reflog(struct ref_store *ref_store,
>  
>  static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
>  {
> -	unsigned char osha1[20], nsha1[20];
> +	struct object_id ooid, noid;
>  	char *email_end, *message;
>  	unsigned long timestamp;
>  	int tz;
>  
>  	/* old SP new SP name <email> SP time TAB msg LF */
>  	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
> -	    get_sha1_hex(sb->buf, osha1) || sb->buf[40] != ' ' ||
> -	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
> +	    get_oid_hex(sb->buf, &ooid) || sb->buf[40] != ' ' ||
> +	    get_oid_hex(sb->buf + 41, &noid) || sb->buf[81] != ' ' ||

Some magic numbers above could be converted to use constants.

>  	    !(email_end = strchr(sb->buf + 82, '>')) ||
>  	    email_end[1] != ' ' ||
>  	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
> @@ -3136,7 +3136,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
>  		message += 6;
>  	else
>  		message += 7;
> -	return fn(osha1, nsha1, sb->buf + 82, timestamp, tz, message, cb_data);
> +	return fn(&ooid, &noid, sb->buf + 82, timestamp, tz, message, cb_data);

Here, too.

>  }
>  
>  static char *find_beginning_of_line(char *bob, char *scan)
> [...]
> @@ -4047,14 +4047,14 @@ static int files_reflog_expire(struct ref_store *ref_store,
>  		 */
>  		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
>  			!(type & REF_ISSYMREF) &&
> -			!is_null_sha1(cb.last_kept_sha1);
> +			!is_null_oid(&cb.last_kept_oid);
>  
>  		if (close_lock_file(&reflog_lock)) {
>  			status |= error("couldn't write %s: %s", log_file,
>  					strerror(errno));
>  		} else if (update &&
>  			   (write_in_full(get_lock_file_fd(lock->lk),
> -				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
> +				oid_to_hex(&cb.last_kept_oid), 40) != 40 ||

More magic numbers above.

>  			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
>  			    close_ref(lock) < 0)) {
>  			status |= error("couldn't write %s",
> [...]

I thought it would make sense to convert `struct read_ref_at_cb` in
`refs.c` to use `struct object_id` at the same time, but I see that
would require the interface to `read_ref_at()` to change. I guess it's
important to pick your battles in this campaign :-)

Michael

