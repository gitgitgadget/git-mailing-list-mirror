X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 06/26] refs.c: move delete_pseudoref and delete_ref
 to the common code
Date: Wed, 21 Oct 2015 15:04:01 -0400
Organization: Twitter
Message-ID: <1445454241.8302.14.camel@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
	 <1444938410-2345-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 21 Oct 2015 19:04:23 +0000 (UTC)
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=pMPJYC0N32ILGdpCd7KMfX0a/GbbNqe0L+Fy7ItrFrg=;
        b=WHtqty/CIBvgh0+xu5MiGoADBOEliobohBA6BBMg5xTVtTcsFUAUGSvOxooUSOj6qZ
         dMdEn/t95lFwOdQkHA0SPLTyGUDn6CqFeNLGDGHeck/3hXQ7vjnzjO3WeuV7UQmoS04+
         g3OmAIzA8ApcxHIEXhxDbL6cZQC0y8cd0DXO8+kwiub5AVg0g0IiAuvN8Ye7Rir53FLt
         OBV6zPQZXkcQyuYwfGEcg5Ss4xXj6F8pzbCCvng++CBDuf4fvbVPzCT3hcwl3DNgckuI
         HFPl2LIcxSYYJWKSo39Z4cCzjlsGWznn7UzQfAqKYvduPF2QZ23z7pNvLruNBfvIgsYI
         jwTw==
X-Gm-Message-State: ALoCoQmXQ3gIGx+1EwCyqR4nyfxcvQVSuGmZpFnXGNs7ILzQVR05DWLZOfFT0ggLNnAf94NDPQNP
X-Received: by 10.66.255.66 with SMTP id ao2mr12155521pad.55.1445454245397;
        Wed, 21 Oct 2015 12:04:05 -0700 (PDT)
In-Reply-To: <1444938410-2345-7-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1ZoygH-0004qf-I8 for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:04:13
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755537AbbJUTEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015
 15:04:08 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35557 "EHLO
 mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1754532AbbJUTEG (ORCPT <rfc822;git@vger.kernel.org>); Wed, 21 Oct
 2015 15:04:06 -0400
Received: by pasz6 with SMTP id z6so62392547pas.2 for <git@vger.kernel.org>;
 Wed, 21 Oct 2015 12:04:05 -0700 (PDT)
Received: from ubuntu ([8.25.196.26]) by smtp.gmail.com with ESMTPSA id
 yp9sm10483252pab.1.2015.10.21.12.04.02 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128); Wed, 21 Oct 2015 12:04:04
 -0700 (PDT)
Sender: git-owner@vger.kernel.org

On Thu, 2015-10-15 at 15:46 -0400, David Turner wrote:
> --- a/refs.c
> +++ b/refs.c
> @@ -117,3 +117,60 @@ int update_ref(const char *msg, const char *refname,
>  		ref_transaction_free(t);
>  	return 0;
>  }
> +
> +
> +static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)

extra newline (will fix on reroll)

