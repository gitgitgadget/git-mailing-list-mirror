From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] http: add support for specifying the SSL version
Date: Wed, 12 Aug 2015 14:20:11 -0400
Message-ID: <20150812182011.GA3803@flurp.local>
References: <1439389491-21669-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 20:20:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPadX-00016I-Er
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 20:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbbHLSUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 14:20:20 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36420 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbHLSUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 14:20:17 -0400
Received: by iodv127 with SMTP id v127so12839630iod.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JByhbkX/nPaFDux4xksHTQxSfqCEjVXmEppVGZNPlyU=;
        b=DVP/rTpufSu5+e2FfzcQVdrGSkJp3cS3c0AJoBNlgXCwleBenB+J7NZCoBRQBC3SH4
         y8i+QFOk9J6fQfw6YS+cJTM+AA/gn8GxlT9PzgykjmJhBG+cM2PzkzZqtAkAaOkeJdiD
         b663saPGgMrQ0a9eQgdt99HScjMwbP2Ii7EO1UvBzPjdPDfApzl0yFKowrAAh5bQxtcE
         NMrd4QJQElA3dUJJAL11HWT8Tz3hQRqmMgiO9kjQmVVbGEaQ8PDzZao8xRVMHJ3rIxbx
         sdE5rqoPGFGQGxs6a3y+gGwyNNGxYhZ9U+LZ18mITG3jvR/Y8kz2+8Yzsbo2kv+9j0iU
         7Q7w==
X-Received: by 10.107.168.40 with SMTP id r40mr33719319ioe.20.1439403617185;
        Wed, 12 Aug 2015 11:20:17 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id c79sm4377885iod.9.2015.08.12.11.20.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 11:20:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1439389491-21669-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275790>

On Wed, Aug 12, 2015 at 04:24:51PM +0200, Elia Pinto wrote:
> Teach git about a new option, "http.sslVersion", which permits one to
> specify the SSL version  to use when negotiating SSL connections.  The
> setting can be overridden by the GIT_SSL_VERSION environment
> variable.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 315f271..76a4f2b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1595,6 +1595,27 @@ http.saveCookies::
> +http.sslVersion::
> +	The SSL version to use when negotiating an SSL connection, if you
> +	want to force the default.  The available and default version depend on
> +	whether libcurl was built against NSS or OpenSSL and the particular configuration
> +	of the crypto library in use. Internally this sets the 'CURLOPT_SSL_VERSION'
> +	option; see the libcurl documentation for more details on the format
> +	of this option and for the ssl version supported. Actually the possible values
> +	of this option are:
> +
> +	- sslv2
> +	- sslv3
> +	- tlsv1
> +	- tlsv1.0
> +	- tlsv1.1
> +	- tlsv1.2
> ++
> +Can be overridden by the 'GIT_SSL_VERSION' environment variable.
> +To force git to use libcurl's default ssl version and ignore any
> +explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
> +empty string.

Unfortunately, this won't format properly in Asciidoc; the final
paragraph will be indented as part of the itemized list supported SSL
versions. Here's a squash-in to fix it:

---- 8< ----
Subject: [PATCH] fixup! http: add support for specifying the SSL version

---
 Documentation/config.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 76a4f2b..b23b01a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1610,6 +1610,7 @@ http.sslVersion::
 	- tlsv1.0
 	- tlsv1.1
 	- tlsv1.2
+
 +
 Can be overridden by the 'GIT_SSL_VERSION' environment variable.
 To force git to use libcurl's default ssl version and ignore any
-- 
2.5.0.276.gf5e568e
