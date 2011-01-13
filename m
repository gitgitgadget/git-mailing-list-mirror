From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1/2] unpack-trees: handle lstat failure for existing directory
Date: Thu, 13 Jan 2011 13:37:14 +0900
Message-ID: <buobp3ls9l1.fsf@dhlpc061.dev.necel.com>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
	<1230843273-11056-2-git-send-email-drizzd@aon.at>
	<20110113022415.GA8635@burratino> <20110113022636.GB8635@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 13 05:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdEx8-000632-Io
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 05:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1AMEhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 23:37:31 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:46068 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab1AMEha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 23:37:30 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.197])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p0D4bGS8005293;
	Thu, 13 Jan 2011 13:37:16 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p0D4bGB04010; Thu, 13 Jan 2011 13:37:16 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.9])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id p0D4YjN6008952;
	Thu, 13 Jan 2011 13:37:15 +0900 (JST)
Received: from relay61.aps.necel.com ([10.29.19.40] [10.29.19.40]) by relay41.aps.necel.com with ESMTP; Thu, 13 Jan 2011 13:37:15 +0900
Received: from dhlpc061 ([10.114.97.191] [10.114.97.191]) by relay61.aps.necel.com with ESMTP; Thu, 13 Jan 2011 13:37:15 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 2986552E233; Thu, 13 Jan 2011 13:37:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20110113022636.GB8635@burratino> (Jonathan Nieder's message of
	"Wed, 12 Jan 2011 20:26:36 -0600")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165038>

Jonathan Nieder <jrnieder@gmail.com> writes:
> @@ -1382,7 +1382,9 @@ static int verify_absent_1(struct cache_entry *ce,
>  		return check_ok_to_remove(ce->name, ce_namelen(ce),
>  				ce_to_dtype(ce), ce, &st,
>  				error_type, o);
> -
> +	if (errno != ENOENT)
> +		return error("cannot stat '%s': %s", ce->name,
> +				strerror(errno));
>  	return 0;

Is errno guaranteed to be set to something relevant at this point in the
code...?

-miels

-- 
Religion, n. A daughter of Hope and Fear, explaining to Ignorance the nature
of the Unknowable.
