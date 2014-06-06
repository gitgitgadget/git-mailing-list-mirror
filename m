From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/5] hashmap: add enum for hashmap free_entries option
Date: Fri, 06 Jun 2014 19:52:03 +0200
Message-ID: <5391FFC3.5010001@gmail.com>
References: <20140605060425.GA23874@sandbox-ub> <20140605060640.GB23874@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 19:52:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsyJE-0004DR-PM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 19:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbaFFRwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 13:52:04 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32958 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaFFRwD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 13:52:03 -0400
Received: by mail-wi0-f177.google.com with SMTP id f8so1437210wiw.10
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5O37sVEUOBoHF0sw96ktigKSOcZXyG3Ta/dvqKX5qss=;
        b=ZIz3yYNcq+5gV0FqdRNkQJi+e1vUWBVpw8ZfKZltOUO2yMxfDvLBBIfRXS9pUq7wJ9
         LSephKZRUaEpFfas6KgzLxEx69qm9Jw4xhYKJUWipOJmXCD1UlSGxTyPbPVoiksRESl3
         bOFOW3GsK3Kzo+9dCbsv+viTrsw+KlJRZkdHEy3kCwusc2APelDouIZRqxE8oj5kA4do
         vNY4IBaZpjgFjMNPWOleGJziz3IlBQCnCVHFKQIM/C7JiUQPx4QJdyhoIPNrdukGWaaH
         8/TObCDeNncQXgevEpFr0419tEOwLMh/m3w3wHdU/m/PWgqC00Y7uV3vlufnf7IvZ4rk
         re+A==
X-Received: by 10.14.203.71 with SMTP id e47mr731622eeo.50.1402077120845;
        Fri, 06 Jun 2014 10:52:00 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id l4sm24286684eeo.13.2014.06.06.10.51.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 10:51:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140605060640.GB23874@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250954>

Am 05.06.2014 08:06, schrieb Heiko Voigt:
> This allows a reader to immediately know which options can be used and
> what this parameter is about.
> 
[...]
> -void hashmap_free(struct hashmap *map, int free_entries)
> +void hashmap_free(struct hashmap *map, enum hashmap_free_options free_entries)
[...]
>  
> +enum hashmap_free_options {
> +	HASHMAP_NO_FREE_ENTRIES = 0,
> +	HASHMAP_FREE_ENTRIES = 1,
> +};

This was meant as a boolean parameter. Would it make sense to have

enum boolean {
	false,
	true
};

or similar in some central place?

Note that an earlier version took a function pointer, and you could pass stdlib's free() in the common case, or a special free routine for nested entry structures, or NULL to do the cleanup yourself.
