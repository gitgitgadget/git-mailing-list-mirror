From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Mon, 19 Aug 2013 13:46:18 -0700
Message-ID: <7vmwodl885.fsf@alter.siamese.dyndns.org>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
	<33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
	<20130819204044.GA29258@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	"Koch\, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 19 22:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWLK-0002xb-JM
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 22:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab3HSUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 16:46:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab3HSUqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 16:46:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F8DB39E8C;
	Mon, 19 Aug 2013 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lE4EfQbLAFCyY+FDd5UJ19seUa4=; b=BUlwe9
	DgaB3KJU9bhDFgPHrZ8KjxtL+B2D1Vho+BoLQ4IqBhc4pD2vIMas/XFTuumiN5Gl
	E/yWIcWt19NUUB/umlkMiRMTKP/X10LsFjoYH1i794lVDeLuJ/XAgz2SXqGk4PE/
	7ASj0GQggan3BSRYT88nPvrHCem5ajblSsp1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HSFi6c+sNLOgDVqkItTUbhWjFPne1Ga8
	5TUamOgjN4kXFsVzY1yKozbBUZPOMSAxu+n4g6g1h9jCcJSyOT8UnHK2W2KqYd2l
	V4Sp3GGKnwmnqwcdrphWQLDKHdQnc9paNkuPyeNtqV80uyIVc7N7JRlqAjyNwKTV
	1dC6UXM2/3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6024739E8B;
	Mon, 19 Aug 2013 20:46:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 646A039E86;
	Mon, 19 Aug 2013 20:46:20 +0000 (UTC)
In-Reply-To: <20130819204044.GA29258@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 19 Aug 2013 16:40:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 670B88AC-0910-11E3-AA6A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232563>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 19, 2013 at 09:03:21PM +0100, Philip Oakley wrote:
>
>> In case other readers don't have a .xlsx reader here is Rick's list
>> in plain text (may be white space damaged).
>> 
>> I expect some will be false positives, and some will just be being
>> too cautious.
>>
>> [...]
>> 
>> description resourceFilePath fileName lineNumber
>>      nullPointer(CppCheck) \git-master\builtin\add.c add.c 286
>
> Hm. That code in v1.8.3.4 reads:
>
>         if (pathspec)
>                 while (pathspec[pc])
>                         pc++;
>
> What's the problem? If pathspec is not properly terminated, we can run
> off the end, but I do see anything to indicate that is the case. What
> does the "nullPointer" check mean here?
>
>>      wrongPrintfScanfArgNum(CppCheck) \git-master\builtin\fetch.c
>> fetch.c 588
>
> Line 588 does not have formatted I/O at all. Are these line numbers
> somehow not matching what I have in v1.8.3.4?
>
>>      nullPointer(CppCheck) \git-master\builtin\ls-files.c ls-files.c
>> 144
>
> This one looks like:
>
>        if (tag && *tag && show_valid_bit &&
>             (ce->ce_flags & CE_VALID)) {
>                 static char alttag[4];
>                 memcpy(alttag, tag, 3);
>                 if (isalpha(tag[0]))
>
> where the final line is 144. But we have explicitly checked that tag is not
> NULL...
>
>>      doubleFree(CppCheck) \git-master\builtin\notes.c notes.c 275
>
> This one looks like:
>
>   if (...) {
>     free(buf);
>     die(...);
>   }
>   ...
>   free(buf);
>
> which might look like a double free if you do not know that die() will
> never return (it is properly annotated for gcc, but I don't know whether
> CppCheck understands such things).
>
> So out of the 4 entries I investigated, none of them looks like an
> actual problem. But I'm not even sure I am looking at the right place;
> these don't even seem like things that would cause a false positive in a
> static analyzer.

And the ones I picked at random looks totally bogus, too.

     uninitvar(CppCheck) \git-master\notes.c notes.c 805
     uninitvar(CppCheck) \git-master\notes.c notes.c 805

That is

        int combine_notes_concatenate(unsigned char *cur_sha1,
                        const unsigned char *new_sha1)
        {
                char *cur_msg = NULL, *new_msg = NULL, *buf;
                unsigned long cur_len, new_len, buf_len;
                enum object_type cur_type, new_type;
                int ret;

                /* read in both note blob objects */
                if (!is_null_sha1(new_sha1))
                        new_msg = read_sha1_file(new_sha1, &new_type, &new_len);
805:            if (!new_msg || !new_len || new_type != OBJ_BLOB) {
                        free(new_msg);
                        return 0;
                }


new_msg starts out to be NULL, if we did not run read_sha1_file(),
it will still be NULL and "if()" will not look at new_len/new_type
so their being uninitialized does not matter.  If we did run
read_sha1_file(), and if it returns a non-NULL new_msg, both of
these are filled.  If read_sha1_file() returns a NULL new_msg, again
the other two does not matter.

In short, the analyzer seems to be giving useless noise for this
one.
