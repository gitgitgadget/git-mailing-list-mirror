From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Tue, 10 Apr 2012 10:56:05 -0700
Message-ID: <7vty0rpj2i.fsf@alter.siamese.dyndns.org>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
 <20120410173616.GA4300@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ross Lagerwall <rosslagerwall@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfId-0001bg-WD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab2DJR4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:56:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab2DJR4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:56:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A017EF2;
	Tue, 10 Apr 2012 13:56:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=keL7VEH0UWFUyCeznOSOk6y3qj4=; b=GPww38
	DmBsnXuLWwGIGBDKhVmGH57Lsy4ZZ0gqFD5XpmNWmWja3lYvTi3uFVIfQR8E5c7M
	6o/08C4HKSzeBgh+ngdVUfhBap88wzZk2E62eH9oFLPA5jjVw8V0fxNNbMW/oEPr
	16lEpGziF7T25fhzXss4Dx3Lb2yOqDsTliXJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EpcY/I5ld7XIsmbUnIaB5pKQKczyDymb
	JjRqCiIzycgF6nYDygqU5IZn4f8ihcjNHy1a3ixB1uo7mA+sSnIMh9Up64RemiOo
	H1d0K4ZlDEoqo58XmWGgiXe173uhZ3BGmnuNgG6v4CyJ3/r3Yy1h2AKMqCeAR6/2
	8KG/OFIRuuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B13187EF1;
	Tue, 10 Apr 2012 13:56:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C8B57EF0; Tue, 10 Apr 2012
 13:56:07 -0400 (EDT)
In-Reply-To: <20120410173616.GA4300@burratino> (Jonathan Nieder's message of
 "Tue, 10 Apr 2012 12:36:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72A3390A-8336-11E1-A7EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195111>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (cc-ing Duy)
> Hi,
>
> Ross Lagerwall wrote:
>
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -634,6 +634,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>>  			if (!strcmp(arg, "--show-prefix")) {
>>  				if (prefix)
>>  					puts(prefix);
>> +				else
>> +					putchar('\n');
>>  				continue;
>
> This makes the output more consistent but it is a little puzzling how
> it does that.  Why is prefix NULL instead of "" when we are at the
> toplevel of the worktree?

Interesting point ;-)
