From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug in "git rev-parse --verify"
Date: Sat, 30 Mar 2013 04:44:22 +0100
Message-ID: <51565F96.1020203@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com> <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net> <7vli97v558.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 04:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULmiu-0004Z9-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 04:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab3C3Do2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 23:44:28 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:61384 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757863Ab3C3Do1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 23:44:27 -0400
X-AuditID: 12074413-b7f226d000000902-26-51565f9a02be
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.81.02306.A9F56515; Fri, 29 Mar 2013 23:44:26 -0400 (EDT)
Received: from [192.168.69.140] (p57A248DB.dip.t-dialin.net [87.162.72.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2U3iNdO018239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Mar 2013 23:44:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vli97v558.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqDsrPizQ4OZJI4uuK91MFg29V5gt
	Vky5x2Lxo6WH2YHF41nvHkaPi5eUPT5vkgtgjuK2SUosKQvOTM/Tt0vgzvj5LqTgi0DFio/n
	WRoYr/B2MXJySAiYSCxrOcwCYYtJXLi3nq2LkYtDSOAyo8SHW49ZIZwzTBKfPh5mB6niFdCW
	mPr4BBuIzSKgKnFm72mwbjYBXYlFPc1MILaoQJjE3gvT2CDqBSVOznwCViMioCYxse0QmM0s
	UCDxZvs3ZhBbWEBH4nhPBwvEsheMEhO+PwNr5hQwk5hws4MRokFH4l3fA2YIW15i+9s5zBMY
	BWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoSEsfAO
	xl0n5Q4xCnAwKvHwSqwKDRRiTSwrrsw9xCjJwaQkyjstLixQiC8pP6UyI7E4I76oNCe1+BCj
	BAezkgiv/Aqgct6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO9bkKGC
	RanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZGK0iKB2hvE0g7b3FBYi5QFKL1
	FKMuR9eiz68YhVjy8vNSpcR5j4IUCYAUZZTmwa2AJa1XjOJAHwvzMgJTmBAPMOHBTXoFtIQJ
	aMnyr8EgS0oSEVJSDYxOv4rtSxnXb+79xvlv4ttJzn0rrst6W8ik79ZllFvdfj9kI8e54mM3
	5r26cWXqmv8n33x7V7/9n4bkpC2zOKp9GIs+bvXva+PsdtrqkFP3Zomr/0m7JR6z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219552>

On 03/28/2013 05:52 PM, Junio C Hamano wrote:
> You could force rev-parse to resolve the input to an existing
> object, with something like this:
> 
> 	git rev-parse --verify "$ARG^{}"
> 
> It will unwrap a tag, so the output may end up pointing at a object
> that is different from $ARG in such a case.

Yes, if unwrapping tags is OK then this would work.

> But what is the purpose of turning a random string to a random
> 40-hex in the first place?

In non-trivial scripts, it makes sense to convert user input into a
known and verified quantity (SHA1) once, while processing external
inputs, and not have to think about it afterwards.  Verifying and
converting to pure-SHA1s as soon as possible has several advantages:

1. An SHA1 is a canonical representation of the argument, useful for
example as the key in a hash map for for looking for the presence of a
commit in a rev-list output.

2. An SHA1 is persistent.  For example, I use them when caching
benchmark results across versions.  Moreover, they are safe for use in
filenames.  The persistence also makes scripts more robust against
simultaneous changes to the repo by other processes, whereas if I use a
string like "branch^" multiple times, there is no guarantee that it
always refers to the same commit.

3. Verifying arguments at one spot centralizes error-checking at the
start of a script and eliminates one reason for random git commands to
fail later (when error recovery is perhaps more difficult).

4. Converting once avoids the overhead of repeated conversion from a
free-form committish into an object name if the argument needs to be
passed to multiple git commands (though presumably the overhead is
insignificant in most cases).

Undoubtedly in many cases this practice of
early-verification-and-conversion is unnecessary, or the same benefit
could be had from either verifying or converting without doing both.
But verifying-and-converting is easy, cheap, and means not having to
decide on a case-by-case basis whether it could have been avoided.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
