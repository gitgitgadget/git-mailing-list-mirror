From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 12/21] Use prefixcmp() instead of memcmp() for cleaner code with less magic numbers
Date: Sat, 9 Jun 2007 23:42:40 +0200
Message-ID: <81b0412b0706091442m6594260btd3b898bfb63e1fbb@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	 <200706090210.36270.johan@herland.net>
	 <200706090217.49818.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:42:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8ho-00017t-AK
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbXFIVmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXFIVmm
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:42:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:9882 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbXFIVmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:42:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1203746ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 14:42:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nImHNPoi7rWtgXB+OzhmwzFUZaaZrnYYFpiFBK5XHF2+sIGHQX5BrExoYQsuHGrv6wo1J8J10S85JMWtife7Z3ov1EsUJ5ULbvJgMxIIHvnYydwBSjSV1mU5nVZz9HBVcVUp63yqNbFRSOEfmyTXNttVEWa5eD8OJbEhriLQXsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kt8n/CVH9Q02RXSPZW7RIUEz0C+WPhJ0PC1hwQJhgqs10mfYz3PguHxoBOnZKV5EOVmrejAmK4i0hv5cYFoF1JnPLPax3x/Wqr5ksj02m1mXDaLtgZlEZdRB8CoMhcxvPgUDsAjra+2PFLnJH/ffVVHbritNGEcP4Lg3jFwz5to=
Received: by 10.78.180.18 with SMTP id c18mr1675957huf.1181425360869;
        Sat, 09 Jun 2007 14:42:40 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 14:42:40 -0700 (PDT)
In-Reply-To: <200706090217.49818.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49626>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> +/*
> + * Perform parsing and verification of tag object data.
> + *
> + * The 'item' parameter may be set to NULL if only verification is desired.
> + *
> + * The given data _must_ be null-terminated.
> + */
>  int parse_and_verify_tag_buffer(struct tag *item,
>                 const char *data, const unsigned long size, int thorough_verify)

This hunk really belongs into commit which introduced the function
parse_and_verify_tag_buffer.
