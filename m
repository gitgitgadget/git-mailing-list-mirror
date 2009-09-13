From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] preserve mtime of local clone
Date: Sat, 12 Sep 2009 20:06:51 -0700
Message-ID: <7vvdjn4k6s.fsf@alter.siamese.dyndns.org>
References: <20090909195158.GA12968@localhost> <7vmy50lpfr.fsf@alter.siamese.dyndns.org> <20090912082624.GA9654@localhost> <20090912090348.GB9654@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,  "Shawn O. Pearce" <spearce@spearce.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Sep 13 05:07:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmfQx-0002DG-PV
	for gcvm-msysgit@m.gmane.org; Sun, 13 Sep 2009 05:07:24 +0200
Received: by ywh4 with SMTP id 4so6119942ywh.9
        for <gcvm-msysgit@m.gmane.org>; Sat, 12 Sep 2009 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=cF6e87KAVLs555NEmMmhSeAEJJ9nLtpSnAWZ1X/T/cg=;
        b=B43JCEFD/FggieRWJt7rKCG60CLdFljAdOtpT9iNgFXM03OaGQKstz9/wP7D2K4FtD
         zvOWP1BMMRxBb2+c7fehd8lHqgwtID9Gw1uTWR50Eqj5OFoLUSa4eCCqhUXEkq4l+JNo
         NV4HAJ/VsU4xIPXzwUzI9l9UAjrYZiMQq80r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=0g0Jh9uSphlNBBhqG9OMOyYwuS0wWqauUpsj65+LS4GF9mDnGBJaAhGZJWXaXmXKVV
         0+IBe3uXKvIhbbcVkmEPc1fi9s04CyNR1IllhnNOUWN0aPqfz6IOYC5CkzLPihJHC3Nu
         V/ulKVXZPMzaSqfa5hZh8iGwGIsYUGloq/aQQ=
Received: by 10.100.205.1 with SMTP id c1mr1119112ang.2.1252811236168;
        Sat, 12 Sep 2009 20:07:16 -0700 (PDT)
Received: by 10.176.207.9 with SMTP id e9gr6930yqg.0;
	Sat, 12 Sep 2009 20:07:11 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.224.48.210 with SMTP id s18mr658248qaf.29.1252811230112; Sat, 12 Sep 2009 20:07:10 -0700 (PDT)
Received: by 10.224.48.210 with SMTP id s18mr658247qaf.29.1252811229931; Sat, 12 Sep 2009 20:07:09 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25]) by gmr-mx.google.com with ESMTP id 18si658139qyk.5.2009.09.12.20.07.08; Sat, 12 Sep 2009 20:07:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2136630F19; Sat, 12 Sep 2009 23:07:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; s=sasl; bh=oUM5htYLFGFFN9ZOqQqTDQ/Z0a8=; b=DqI2DW Uu3nwFqUyKNj8XEbAox2m4oD1ee6B6f5ssL75N83OVa+bjV2Axc5+N8LzkrNst+I b6zgodlr9IqhsSIQNnHQUs9CDlZnCjJC98Cla7QTJ+AwqaK8rgeS/TWLkHXBul6i /8bUq8rUTPUG1OphgnAQqUrmpqy04cAB4Q7IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; q=dns; s=sasl; b=FXQpNzediMYhyFB6S4PzghxVwjweI4BT IOf7X8PWDv/yQgNRvW1xEUsALnDI30USFvQtCZC7czRNu0hDj0vc5hhVQ7FHHYjM RHsxV6jSF6gGFlduOml7gPomhSu8GjdZvQsXqo6es4TbEtWwVdi603M5LdGLPv8x ITtnlfAGVmE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E023530F18; Sat, 12 Sep 2009 23:07:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F32C430F16; Sat, 12 Sep 2009 23:06:52 -0400 (EDT)
In-Reply-To: <20090912090348.GB9654@localhost> (Clemens Buchacher's message of "Sat\, 12 Sep 2009 11\:03\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83362CB4-A012-11DE-8F41-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128327>


Clemens Buchacher <drizzd@aon.at> writes:

> A local clone without hardlinks copies all objects, including dangling
> ones, to the new repository. Since the mtimes are renewed, those
> dangling objects cannot be pruned by "git gc --prune", even if they
> would have been old enough for pruning in the original repository.
>
> Instead, preserve mtime during copy. "git gc --prune" will then work
> in the clone just like it did in the original.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>
> On Sat, Sep 12, 2009 at 10:26:24AM +0200, Clemens Buchacher wrote:
>
>> If it's a problem we can use utime() instead. I was just trying to use the
>> file descriptors, since they were available. But the patch would be a little
>> smaller if I didn't touch copy_fd().
>
> Here we go.

Thanks.

This new feature is not wanted by most of the callers of copy_file(), and
it is not like they may want to conditionally pass 1 in preserve_times
someday.  I'd limit the damage like this replacement patch, instead.

Is it unreasonable to have a test for this one, by the way?

 builtin-clone.c |    2 +-
 cache.h         |    1 +
 copy.c          |   21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index ad04808..bab2d84 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -269,7 +269,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest)
 				die_errno("failed to create link '%s'", dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file(dest->buf, src->buf, 0666))
+		if (copy_file_with_time(dest->buf, src->buf, 0666))
 			die_errno("failed to copy file to '%s'", dest->buf);
 	}
 	closedir(dir);
diff --git a/cache.h b/cache.h
index 867918d..1668f28 100644
--- a/cache.h
+++ b/cache.h
@@ -923,6 +923,7 @@ extern const char *git_mailmap_file;
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
 extern int copy_file(const char *dst, const char *src, int mode);
+extern int copy_file_with_time(const char *dst, const char *src, int mode);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
diff --git a/copy.c b/copy.c
index e54d15a..a7f58fd 100644
--- a/copy.c
+++ b/copy.c
@@ -35,6 +35,19 @@ int copy_fd(int ifd, int ofd)
 	return 0;
 }
 
+static int copy_times(const char *dst, const char *src)
+{
+	struct stat st;
+	struct utimbuf times;
+	if (stat(src, &st) < 0)
+		return -1;
+	times.actime = st.st_atime;
+	times.modtime = st.st_mtime;
+	if (utime(dst, &times) < 0)
+		return -1;
+	return 0;
+}
+
 int copy_file(const char *dst, const char *src, int mode)
 {
 	int fdi, fdo, status;
@@ -55,3 +68,11 @@ int copy_file(const char *dst, const char *src, int mode)
 
 	return status;
 }
+
+int copy_file_with_time(const char *dst, const char *src, int mode)
+{
+	int status = copy_file(dst, src, mode);
+	if (!status)
+		return copy_times(dst, src);
+	return status;
+}
