From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 23:27:17 -0800
Message-ID: <7vr4l967u2.fsf@alter.siamese.dyndns.org>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <7vzjzx7w01.fsf@alter.siamese.dyndns.org>
 <20130125055331.GC26524@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 08:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TydhS-0006De-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 08:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab3AYH10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 02:27:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab3AYH1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 02:27:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1C1C6F2D;
	Fri, 25 Jan 2013 02:27:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5X8/LuDvqKDnbgRDLlMcUV5j1SM=; b=HCvmt9
	8KY6T7Ewaisas5AqLJeGImaflUOUou5EF2XLyq1bhPPVkWOT36eGAM/IdMeyMlfd
	+Rtn2iL06PsgWNydmAr/NMBHxTW966IrpFHEzK9K8tQx3FX+GR5E2HLXAWycnsyW
	rSllJARZAaQUE+nuvCUXvUInzjtLLb0djtCZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNZ2zc4ZLW6BMdHiCsCG3U6W85x4RtNY
	tsLqh4DnAuSpXyBAFAeJRx6vrP6bf24yBncFIGVuyAdDjrvRB7ruXCH4o2iL9j3U
	JwmNlv/FkAjTE1NScGUKbGaWl5nCTI0ZDoESjmB87zhSZTp3BcZTb4fOkgl8oYD/
	q7s93lLJcfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71726F2C;
	Fri, 25 Jan 2013 02:27:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15D796F2B; Fri, 25 Jan 2013
 02:27:18 -0500 (EST)
In-Reply-To: <20130125055331.GC26524@elie.Belkin> (Jonathan Nieder's message
 of "Thu, 24 Jan 2013 21:53:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6B247CC-66C0-11E2-8BEC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214508>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Junio C Hamano wrote:
>
>> I've been toying with an idea along this line.
>
> Heh.  Just for fun, here's an uglier version:

Much nicer, though.

>
> 	struct wcb_data {
> 		int had_buffer;
> 		int using_buffer;
> 	};
> 	#define WITH_COMMIT_BUFFER_DATA_INIT { 0, 0 }
>
> 	extern void acquire_commit_buffer(struct commit *, struct wcb_data *);
> 	extern void done_with_commit_buffer(struct commit *, struct wcb_data *);
>
> 	/*
> 	 * usage:
> 	 *	struct wcb_data buf = WITH_COMMIT_BUFFER_INIT;
> 	 *
> 	 *	with_commit_buffer(commit, buf) {
> 	 *		...
> 	 *	}
> 	 */
> 	#define with_commit_buffer(commit, i) \
> 		for (acquire_commit_buffer(commit, &i); \
> 		     i.using_buffer; \
> 		     done_with_commit_buffer(commit, &i))
>
> 	void acquire_commit_buffer(struct commit *commit, struct wcb_data *i)
> 	{
> 		enum object_type type;
> 		unsigned long size;
>
> 		assert(!i->using_buffer);
> 		i->using_buffer = 1;
> 		i->had_buffer = !!commit->buffer;
>
> 		if (i->had_buffer)
> 			return;
> 		commit->buffer = read_sha1_file(commit->object.sha1, &type, &size);
> 		if (!commit->buffer)
> 			die("unable to read commit %s", sha1_to_hex(commit->object.sha1));
> 	}
>
> 	void done_with_commit_buffer(struct commit *commit, struct wcb_data *i)
> 	{
> 		assert(i->using_buffer);
> 		i->using_buffer = 0;
>
> 		if (!i->had_buffer) {
> 			free(commit->buffer);
> 			commit->buffer = NULL;
> 		}
> 	}
