From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Mon, 13 Feb 2012 08:29:43 -0800
Message-ID: <20120213162943.GF4903@tgrennan-laptop>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
 <7vpqdln68v.fsf@alter.siamese.dyndns.org>
 <20120211193742.GD4903@tgrennan-laptop>
 <7vzkcpkkbd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Cc: pclouds@gmail.com, git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 17:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwymp-0000g1-BF
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 17:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198Ab2BMQ3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 11:29:50 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:65497 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab2BMQ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 11:29:48 -0500
Received: by qcqw6 with SMTP id w6so3037240qcq.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=REjYXcozf9ZVCUqdpWIRNEMSM6lRfOHD/nwJBpXmZwY=;
        b=Ytorddn3qKAx7wVBU9xRXF8DOOIfPWdkQj5Tq5zNdi9Zchyu8Nyf5jZQxVgld3pyy8
         B+Xr7fhS8RrpNbHRjuoXFIx+aAFtcWabBwEhziigpUz3HFRZ2Zfm5ppX9mP9ktQYKG6g
         Q5J+O4MSeSD+tMAdEswmoS18hs1RpqctTgshs=
Received: by 10.229.77.66 with SMTP id f2mr9775286qck.4.1329150588038;
        Mon, 13 Feb 2012 08:29:48 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id hi8sm35058865qab.3.2012.02.13.08.29.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 08:29:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzkcpkkbd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190636>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 11, 2012 at 03:43:34PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> Yes, I should have stated that this emphasized containment over
>> efficiency.  If instead we stipulate that the caller must list exclusion
>> patterns before others, this could simply be:
>
>No.
>
>You have to pre-parse and rearrange the pattern[] list *only once* before
>matching them against dozens of refs, so instead of forcing the callers do
>anything funky, you give a function that gets a pattern[] list and returns
>something that can be efficiently used by the match_pattern() function,
>and have the caller pass that thing, not the original pattern[] list, to
>the match_pattern() function.

Hmm, I'm not communicating very well; this is exactly what I meant by,

>> Of course I'd add a with_exclusions_first() before the
>> respective ref iterator.

-- 
TomG

--PEIAKu/WMn1b1Hv9
Content-Type: message/rfc822
Content-Disposition: inline

Date: Sat, 11 Feb 2012 11:37:42 -0800
From: Tom Grennan <tmgrennan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: pclouds@gmail.com, git@vger.kernel.org, jasampler@gmail.com
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Message-ID: <20120211193742.GD4903@tgrennan-laptop>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
 <7vpqdln68v.fsf@alter.siamese.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vpqdln68v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Feb 11, 2012 at 12:06:56AM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> +int refname_match_patterns(const char **patterns, const char *refname)
>> +{
>> +	int given_match_pattern = 0, had_match = 0;
>> +
>> +	for (; *patterns; patterns++)
>> +		if (**patterns != '!') {
>> +			given_match_pattern = 1;
>> +			if (!fnmatch(*patterns, refname, 0))
>> +				had_match = 1;
>> +		} else if (!fnmatch(*patterns+1, refname, 0))
>> +			return 0;
>> +	return given_match_pattern ? had_match : 1;
>> +}
>
>This, while its semantics seem sane, is highly inefficient when you have
>many patterns, and you will be calling this to filter dozens of refs.  And
>it can trivially improved by first pre-parsing the pattern[] array.
>
> * If you know the patterns do not have any negative entry, you can return
>   true upon seeing the first match. Because you do not pre-parse the
>   pattern[] array, this loop does not know if there is any negative one,
>   and has to scan it always all the way.
>
> * If you arrange the pattern[] array so that it has negative ones early,
>   again, you can return false upon seeing the first hit with a negative
>   one. If your input has negative ones at the end, the loop ends up
>   scanning all the way, noting the positive matches, only to discard upon
>   seeing the negative match at the end.
>
>That is why I said Nguyen's idea of reusing pathspec matching logic
>somewhat attractive, even though I think it has downsides (the exact
>matching logic for pathspec is more similar to that of for-each-ref
>and very different from branch/tag).

Yes, I should have stated that this emphasized containment over
efficiency.  If instead we stipulate that the caller must list exclusion
patterns before others, this could simply be:

int match_pattern(const char **patterns, const char *refname)
{
	if (*patterns)
		return 1;
	for (; *patterns && **patterns == '!'; patterns++)
		if (!fnmatch(*patterns+1, refname, 0))
			return 0;
	for (; *patterns; patterns++)
		if (!fnmatch(*patterns, refname, 0))
			return 1;
	return 0;
}

Of course I'd add a with_exclusions_first() before the
respective ref iterator.

-- 
TomG

--PEIAKu/WMn1b1Hv9--
