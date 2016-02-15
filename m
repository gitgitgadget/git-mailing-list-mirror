From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 21/25] fetch: define shallow boundary with
 --shallow-exclude
Date: Mon, 15 Feb 2016 15:15:39 +0700
Message-ID: <20160215081539.GA12609@lanh>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-22-git-send-email-pclouds@gmail.com>
 <CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
 <CACsJy8B=p0frmU8ahc9bnk-uoDPNUT_6UB0MVRPiLc9DqNz3vQ@mail.gmail.com>
 <CAPig+cR01WCgyJQuDcq-j5Z6u3S-LO5kUVuT+g-jdu-hoH-5yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVEJX-00009h-PL
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 09:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbcBOIPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 03:15:20 -0500
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34102 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbcBOIPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 03:15:18 -0500
Received: by mail-pa0-f66.google.com with SMTP id yy13so6903142pab.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 00:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MYde+I873eOoJj1deu1fzWRJk8UafW4oh5O2ipb+bm4=;
        b=vP1pXYg/Fk8sW8awbc9HyVQGhLmicLG2a4PgAGQYLFkpRtX6THrXvQ90O8NOPxImcU
         ysaTd9tybHg9vXOjQOKsNqOxscC4Ubvyp8rQX3OH1pATSGRdTAurAQeYzr/jVfI4IbvM
         /6ZDAIcO3HErU4+7ih023g0Cm7XTYIUfd/WTtO5hc+adxDsEwgJiNlHmbnIj+WA2a0QG
         jfBslO7DJS6nFXcnZ16zWnn7N70iv97GgtBvsJR1RzflzG3Dhl8bHCfi1ToheMUL/YPB
         OehVAeWw6/u+XgjkKK5y0QQpbDYq8SyvkfoAS/kporrApioWxceGEezO+15L3kqXK8l3
         7rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MYde+I873eOoJj1deu1fzWRJk8UafW4oh5O2ipb+bm4=;
        b=R2941i+3Yvm0G9OqKz6e+cw3oZLFLnP/vfY2Ogv0tlsO2SN906DIAfMz4u64szOGas
         baAjPuFP7Ww5v9fz5/wqxTNl2jq+kIEJVHmYPXw+AsTHkFbfzFH5aDbGnDll28R62q+x
         pCovpS0BbiLHyuNUpfVGtKoS1WBMF/QUrSYysvbHdXXXqeLE0g/PWysua5K/fnQBDrZc
         ECvCJq/RdOUymFyaPV7PFAvQQH3NcWMReGTozjQO3RuLMMbNYuQniS8Zel+FEjIJdSud
         70j5tjLHTFBdOOu4HcQM+94GP9WJVPFPFPIsB5wdmx9p1/i8KoCb2+YxEniIyVGBnRN0
         aQ8Q==
X-Gm-Message-State: AG10YOSSp8HYH2vGxIcQrKtfOaGSnyySsKI+JzkxgHfdOSJhnSw/3wWwatHCn36ymaMBaw==
X-Received: by 10.66.220.7 with SMTP id ps7mr8701220pac.58.1455524117574;
        Mon, 15 Feb 2016 00:15:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t87sm36414309pfa.14.2016.02.15.00.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 00:15:15 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 15:15:39 +0700
Content-Disposition: inline
In-Reply-To: <CAPig+cR01WCgyJQuDcq-j5Z6u3S-LO5kUVuT+g-jdu-hoH-5yw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286182>

On Mon, Feb 15, 2016 at 12:52:26AM -0500, Eric Sunshine wrote:
> Yes, dropping 'const' was implied. I didn't examine it too deeply, but
> it did not appear as if there would be any major fallout from dropping
> 'const'. It feels a bit cleaner to keep it all self-contained than to
> have that somewhat oddball static string_list*, but it's not such a
> big deal that I'd insist upon a rewrite.

Dropping 'const' is not a big deal. But before we do that, how about
this instead? I think the code looks better, and the compiler can
still catch invalid updates to deepen_not.

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 0402e27..07570be 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -50,6 +50,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct child_process *conn;
 	struct fetch_pack_args args;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
+	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	packet_trace_identity("fetch-pack");
 
@@ -108,6 +109,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.deepen_since = xstrdup(arg);
 			continue;
 		}
+		if (skip_prefix(arg, "--shallow-exclude=", &arg)) {
+			string_list_append(&deepen_not, arg);
+			continue;
+		}
 		if (!strcmp("--no-progress", arg)) {
 			args.no_progress = 1;
 			continue;
@@ -135,6 +140,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		}
 		usage(fetch_pack_usage);
 	}
+	if (deepen_not.nr)
+		args.deepen_not = &deepen_not;
 
 	if (i < argc)
 		dest = argv[i++];
--
Duy
