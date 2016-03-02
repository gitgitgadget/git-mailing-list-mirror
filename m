From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/10] cleaning up check_repository_format_gently
Date: Tue, 01 Mar 2016 19:42:51 -0500
Organization: Twitter
Message-ID: <1456879371.5981.11.camel@twopensource.com>
References: <20160301143546.GA30806@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 01:43:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aausa-0003iw-F7
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 01:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbcCBAm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 19:42:56 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36492 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbcCBAmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 19:42:54 -0500
Received: by mail-qg0-f54.google.com with SMTP id u110so28036095qge.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 16:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=JcODSFqwDTfNRj3ILlF8yikfnljxInjyKm01kX1BiFQ=;
        b=pzuVPFLrcaKIrVl89T5X6QMP4EGhZfCxfkS2jp9dJjgTVqp2cHIDMvWmxeYvS7YgHQ
         GkKJ6nnIxzqhGY0LtvBUgiQnqmkIfCBXtz64jtTbxiV7/Z5k6+8Fko2QyteOzYH8zJQq
         3k+/RDMdNWa2bVBFeS+r1/8NPekj9J1tOzuk10lzBVUxh8p2syU3Cs4Dj0d0YdMiPoFN
         FphhUMK+K018HpYFZuSZgEvry9oQ4IqzNNMaN0fmbEPYgxBV4Ft3vRBY5pzf6Vd9WBxZ
         AhmiYXMkHpcqOzvNIWLCxCcxRlk8uSa7fzGFYY64thpbCj/BzP5qj0q2qbdDgTNqK1+L
         Vaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=JcODSFqwDTfNRj3ILlF8yikfnljxInjyKm01kX1BiFQ=;
        b=k288XjQtA6Shn3k4upBMg4k0nctod2/g8hxEX10lzKysa36JzBVva+SlArGwihA82D
         ZnWU1KjyOAAaNdrwsPSx5RhMRLVCxMIY4RhfJgWobDeud2Uf0+F1BT1u6SpQqSlu9Ybd
         8NfoRYulIAy3aCypzkI9peJh4UcnVNcbE0Jz6lPopPnGQUBQjqhoMxZgDkM/pmMU+mGC
         nAXntNgfLSvM3+2rMZt85Kw2jJ/nMnIKdc6pIeFjUJ025env5T68zyIj/KaGAhs0zGYr
         m8s9B+3zuWWN7vckE7BnCUNNgMeyH01v0y7cG1RI21uJTFgldS3ct5eglK4FsNt750Kv
         O6ow==
X-Gm-Message-State: AD7BkJJnqJ+WSzYetNcH7TcipArIGNX9XGfwnEpYp5fSC4tNCbUMo3NWm7A3272tRHlm5w==
X-Received: by 10.140.22.139 with SMTP id 11mr30671869qgn.34.1456879373297;
        Tue, 01 Mar 2016 16:42:53 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b66sm1188170qhb.48.2016.03.01.16.42.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 16:42:52 -0800 (PST)
In-Reply-To: <20160301143546.GA30806@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288087>


On Tue, 2016-03-01 at 09:35 -0500, Jeff King wrote:
> After the discussion in:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/287949/focus
> =288002
> 
> I came up with this series to try to address some of the warts in
> check_repository_format_gently().
> 
> I had hoped to come up with something very small that could go at the
> front of the refs-backend series, but as with any time I look at the
> setup code, it managed to snowball into a potpourri of hidden
> assumptions.
> 
> So I hope David isn't _too_ irritated to see this in his inbox.


I commented on two of the patches; the rest look good to me.

I rebased on these (minus the repo_version_string change from 10/10). Wasn't too bad.  And it did clean up the submodule check.

I will wait to resend my series until I hear back about your shortlog/mailmap fix and your suggestion on a better archive --remote fix.  
