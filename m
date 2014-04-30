From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Wed, 30 Apr 2014 18:05:35 +0200
Message-ID: <CABPQNSZVFWhP+oTYpU2HeenJXwMsDNQGegwYZVb=bZ2+BRz3-w@mail.gmail.com>
References: <1398718883-5630-1-git-send-email-dborowitz@google.com>
 <CABPQNSYDD7g3nOwb2ZaOQ9M9gQnjzQyKP4Zo-i8p4o-s30bk1Q@mail.gmail.com> <xmqqk3a6hmv6.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Borowitz <dborowitz@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:06:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfX1b-00034S-F7
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 18:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbaD3QGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 12:06:19 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44165 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422650AbaD3QGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 12:06:18 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so2196551iec.39
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=P8WxGiM/PXdQdS+d41bVBZJY0tCGJFzQAXgmOMEmSrQ=;
        b=QT8kSPERtLavdvtpGkyHNF+l1mlhbwFmvcBX8aCDZCKubwgdAYXAXA2/hByo30NdnX
         I8MD76V7g5Y0/IQ1BYbBr296WUcdtpGi0JWarPr9PhloIDkdFgecrUMaAiJP9tT2Ol69
         DcXcrgmyxNBb4Fv//gsCi9+Lixnd7kWtbHtyz7QN8ENhUFqbvvhZkf793Elmc0hNULSD
         0o60951Qqm2UYBhGSfA6e+J70O/xzK3CTqL5EMBII34W5PGxKSH8a2D7WiZ9t7HwHMdX
         fgCBLTpJVQwiuORJ9hdSfBupuaPLwAlvo0gir+zTXz2Lkva8/onpSwspNWLNWtmOmbKh
         qyiQ==
X-Received: by 10.50.50.146 with SMTP id c18mr38626042igo.42.1398873975350;
 Wed, 30 Apr 2014 09:06:15 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 09:05:35 -0700 (PDT)
In-Reply-To: <xmqqk3a6hmv6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247725>

On Wed, Apr 30, 2014 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think something along the lines of
>
>         ifdef CURLDIR
>                 CURL_LIBCURL =
>         else
>                 CURL_CONFIG = curl-config
>                 CURL_LIBCURL := $(shell sh -c '$(CURL_CONFIG) --libs' 2>/dev/null)
>         fi
>
> may be the right way to write this?
>
> Note that $(shell $(CURL_CONFIG) --libs) when CURL_CONFIG is empty
> would barf when $(CURL_CONFIG) expands to an empty string.

There's still the fact that msysGit does *not* need CURLDIR, but
doesn't have curl-config either. So I think this one will also
complain for us.
