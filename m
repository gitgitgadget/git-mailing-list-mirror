From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exclude: fix a bug in prefix comparison optimization
Date: Sun, 14 Oct 2012 11:25:48 -0700
Message-ID: <7vobk4ykpf.fsf@alter.siamese.dyndns.org>
References: <1350214522-3242-1-git-send-email-pclouds@gmail.com>
 <7v8vb9yn09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:26:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNSsz-00058x-RO
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 20:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab2JNSZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 14:25:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab2JNSZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 14:25:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33F67997D;
	Sun, 14 Oct 2012 14:25:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eydMtnqlyRVqlj1za4UHM2jsK4g=; b=V3iL+8
	pHnd8vMXeHbqO1iRPUrL95ax0Oot0jizEnTezbDRWg00KOL8LdRe9xL3EE6zbnhO
	MOvKckT9EtBXCliuofIqfZGn7KPUYFh6XPWjJT2BFmV8vGwKPDOq2PM9u8Sqk1W0
	IIi8zCAlxijcvdWdKxNcK2bfzgwVQ1hhCmnDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cf9ucigVHK2BS9FCzv6odheH/+Lz2xg6
	alYVNXbP2zhFQ8Hmr0Zaarc382moYrphiWPD7xcE+6lSw8f8kUrPzqCmN0FB0f1P
	z1PVkDo9pGBTW+XnZGA8tL8Mq+dxmQ650i2lzh/KGdC1t/Wmi9TxQAA6maYVOk33
	UWSV7ixTUUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21F6F997C;
	Sun, 14 Oct 2012 14:25:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D463997B; Sun, 14 Oct 2012
 14:25:49 -0400 (EDT)
In-Reply-To: <7v8vb9yn09.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 14 Oct 2012 10:36:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 943BE646-162C-11E2-88F5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207682>

Junio C Hamano <gitster@pobox.com> writes:

> Comparing the corresponding code in dir.c, there is no "compare the
> literal prefix part with strcmp() before doing the fnmatch()"
> optimization.  Intended?
>
> (warning: I haven't had my caffeine yet)

And it turns out that at the point I wrote the response, I still had
the attr-match-optim-more updates to be read in my mailbox ;-)
 
