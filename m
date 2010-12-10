From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/18] Gitweb caching v8
Date: Fri, 10 Dec 2010 02:27:27 +0100
Message-ID: <201012100227.27903.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <m3bp4u34vj.fsf@localhost.localdomain> <4D017796.4030506@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQrlv-0008U5-62
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710Ab0LJB1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:27:37 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:54775 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab0LJB1g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 20:27:36 -0500
Received: by fxm18 with SMTP id 18so3179961fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 17:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VyYCFmefip328e8bdIIFDyAz5RfWPOn67R3HQU9xNUE=;
        b=EYYTKleK1gg8/9a64cz3PHoM0Nx7iyilm1jE8YTT8d9vgYuR9UXrTkjr5hYYfp+GNo
         R08AEmJMhwR5nmqc+0yvaWF72CIsihoN2ubbJAHe71S1+3Lz0xz2zfg2RfJ7Qo57Q7pE
         5UcE2xexevusERjkI9bRu8sivcJ9oWKndMaMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cyrzHDX915hU/G+asTYcb7DLCQEqqIZPfbkq7ce6CmsG8yGssdGrMcLMYfVx0Kt9CD
         QsZgyEVo3fRb3tIHSUjI/ZISIEodl/LeDK5Y7qCeVhimOdlQBqv2IGbmP0CjTN78Ib/e
         Ox2rVFKpiscxxJzvMu7KCussFi/YZgxmY+StY=
Received: by 10.223.78.206 with SMTP id m14mr165574fak.73.1291944453112;
        Thu, 09 Dec 2010 17:27:33 -0800 (PST)
Received: from [192.168.1.13] (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n1sm746655fam.40.2010.12.09.17.27.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 17:27:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D017796.4030506@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163374>

On Fri, 10 Dec 2010, J.H. wrote:
> On 12/09/2010 03:26 PM, Jakub Narebski wrote:

>> John, could you please in the future Cc me?  I am interested in gitweb
>> output caching development.  Thanks in advance.
> 
> Apologies, apparently screwed up on my git send-email line.  I'll get
> that right one of these eons.

Ah, I can understand this.

>> I guess that in the final submission (i.e. the one that is to be
>> merged in into git.git repository) those changes would be squashed in,
>> isn't it?
> 
> I have no objections to squashing the reversions into a single patch,
> just figured it was easier to break them out for the time being.

I guess that interdiff in comments would work as well, or almost as well...
 
>>> There is one additional script I've written that the Fedora folks are using,
>>> and that might be useful to include, which is an 'offline' cache file generator.
>>> It basically wraps gitweb.cgi and at the end moves the cache file into the right
>>> place.  The Fedora folks were finding it took hours to generate their front
>>> page, and that doing a background generation almost never completed (due to 
>>> process death).  This was a simple way to handle that.  If people would like
>>> I can add it in as an additional patch.
>> 
>> Are you detaching the background process?

Errr... what I meant here is that perhaps detaching background process
would make it not die, but I am guessing here.
 
> No, in fact I completely turn off forking (using the $cacheDoFork variable.)

BTW. what I don't like is your code forking indiscriminately even if it
is not needed (e.g. background cache generation is turned off).

> 
>> It would be nice to have it as separate patch.
> 
> I can add it easily enough.

It is only about caching most IO intensive page, i.e. projects_list page,
isn't it?  Why doesn't _it_ die, like background process?

> 
>>> v8:
>>> 	- Reverting several changes from Jakub's change set that make no sense
>>>                 - is_cacheable changed to always return true - nothing special about
>>>                   blame or blame_incremental as far as the caching engine is concerned
>> 
>> 'blame_incremental' is just another version of 'blame' view.  I have
>> disabled it when caching is enabled in my rewrite (you instead disabled
>> caching for 'blame_incremental' in your v7 and mine v7.x) because I
>> couldn't get it to work together with caching.  Did you check that it
>> works?
> 
> blame works fine, blame_incremental generates but doesn't..... ohhhh
> someone added ajaxy kinda stuff and doesn't mention it anywhere.

Errr... I thought that the 'incremental' part is self-explaining that
it is Ajax-y stuff.  Well, while commit is 4af819d (gitweb: Incremental
blame (using JavaScript), 2009-09-01), perhaps I should have added some
comment in the code.

> 
> Exciting.
> 
> blame_data needs to not get a 'generating...' page in all likelihood,
> generating a blame_incremental page, letting it load and then refreshing
> the whole thing gets me what I'm expecting.

Hmmm... I wonder why it didn't work for me at that time...

> 
> Is enough to mask.
> 
> Guess I'm looking at a v9 now.
> 
>> Besides, withou "tee"-ing, i.e. printing output as it is captured,
>> cached 'blame_data' means that 'blame_incremental' is not incremental,
>> and therefore it vanishes its advantage over 'blame'.

I mean here that with current state of caching 'blame_incremental' stops
to be incremental...
 
> There are only 2 ways to get to a blame_incremental page
> 
> 1) By going to a blame page and clicking on the incremental link in the nav
> 
> 2) By enabling it by default so when you click 'blame' it goes to
> incremental first.

  3) By having JavaScript add ';js=1' to all links, so clicking on
  'blame' link (with action set to 'blame') would result in 
  'blame_incremental' view.

> 
>> In the case data is in cache, then 'blame_inremental' doesn't have
>> advantage over 'blame' either.
> 
> Agreed, though it's easy enough to support in the caching engine,
> basically don't return 'Generating...' and wait for that data to cache.
> Not really an advantage except that your not waiting for the whole
> generation to get a page back at all.
> 
>>>                 - Reverted change to reset_output as
>>>                         open STDOUT, ">&", \*STDOUT_REAL;
>>>                   causes assertion failures:
>>>                   Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.
>>>                   if we encounter an error *BEFORE* we've ever changed the output.
>> 
>> Which Perl version are you using?  Because I think you found error in Perl.
>> Well, at least I have not happen on this bug.
> 
> This is perl, v5.10.0 built for x86_64-linux-thread-multi

Could you check with newer perl?  I don't get this error.

>> I have nothing againts using
>> 
>>   open STDOUT, ">&STDOUT_REAL";
>> 
>> though I really prefer that you used lexical filehandles, instead of
>> "globs" which are global variables.

And using 'print STDOUT_REAL "";' protects against spurious warning
(the warning is really wrong in this case).
 
>> The following works:
>> 
>>   open STDOUT, '>&', fileno($fh);
>> 
>> Note that fileno(Symbol::qualify_to_ref($fh)) might be needed...
> 
> I see 0 advantage to shifting around STDOUT and STDERR to a lexical
> filehandle vs. a glob in this case.  STDOUT_REAL retains all the
> properties of STDOUT should it be needed elsewhere, including what it
> was going and what it was doing.
> 
> I have no objection to shifting the file handles I'm using to lexical
> variables, if nothing else the argument about them closing when falling
> out of scope is worth it, but for STDOUT, STDERR, etc I don't think
> switching to lexicals makes a lot of sense

Well... I'd have to agree that in current case (capturing engine embedded
in gitweb, and gitweb-specific; no need for recursive capture) it would
be enough to use such globs.

> 
>>>         - Cleanups there were indirectly mentioned by Jakub
>>>                 - Elimination of anything even remotely looking like duplicate code
>>>                         - Creation of isBinaryAction() and isFeedAction()
>> 
>> Could you please do not use mixedCase names?
> 
> I'm fine with renaming those if you wish.
> 
>> First, that is what %actions_info from
>> 
>>   [PATCH 16/24] gitweb: Introduce %actions_info, gathering information about actions
>>   http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163038
>>   http://repo.or.cz/w/git/jnareb-git.git/commitdiff/305a10339b33d56b4a50708d71e8f42453c8cb1f
>> 
>> I have invented for.
> 
> I have not based any of my caching engine, right now, on anything you've
> done for your rewrite.

What I meant here that if you will be doing yet another version, you
can take a look at it as a way to avoiding not very clear and nice
long alternatives in condition, or in regexp matched.

> 
>> Second, why 'isBinaryAction()'?  there isn't something inherently
>> different between binary (':raw') and text (':utf8') output, as I have
>> repeatedly said before.
> 
> It's a binary action in that you are shoving something down the pipe
> with the intention of sending the bits completely raw.  You read the
> data raw, and write the data raw.  There is no interpretation of the
> data as being anything but straight raw.
> 
> Right now, in gitweb already, there are two places that treat output
> completely differently:
> 
> 	- snapshot
> 	- blob_plain
> 
> The only reason isBinaryAction() (or any other function name or process
> you want to grant it) exists is so that I can figure out if it's one of
> those actions so I can deal with the cache and output handling
> differently for each.
> 
> Yes, I could flip the entire caching engine over to following the same
> mantra for everything and thus there is no need to care, but gitweb
> itself isn't really setup to handle that separation cleanly right now,
> and I'm trying to make as few bigger changes right now as is.

Always reading from cache in ':raw' mode and always printing from cache
in ':raw' mode (i.e. setting STDOUT to ':raw' before printing / copying
cache entry) would be in gitweb case enough to not special-case binary
files.

In gitweb you always do "binmode STDOUT, ':raw';" _after_ starting capture,
which means that it gets applied to cache file; and gitweb always do
"binmode STDOUT, ':utf8';" before stopping capture.

If you print text data to file using ':utf8' layer (applied at beginning
to cache file) it is in this file as correct sequence of bytes.  Therefore
you can dump said cache file to STDOUT in ':raw' mode (or in ':utf8' mode)
- both STDOUT and read cache file has to have the same mode.

>>>         - Added better error handling
>>>                 - Creation of .err file in the cache directory
>>>                 - Trap STDERR output into $output_err as this was spewing data prior
>>>                   to any header information being sent
>> 
>> Why it is needed?  We capture output of "die" via CGI::Util::set_message,
>> and "warn" output is captured to web server logs... unless you explicitely
>> use "print STDERR <sth>" -- don't do that instead.
> 
> I have seen, in several instances, a case where git itself will generate
> an error, it shoves it to STDERR which makes it to the client before
> anything else, thus causing 500 level errors.
> 
> Added this so that STDERR got trapped and those messages didn't make it out.

Could you give examples when it happens?  Anything that happens after
"use CGI::Carp" is parsed should have STDERR redirected to web server
errors log.

I'll read the actual patch and comment on it.

> 
>>>         - Added hidden field in footer for url & hash of url, which is extremely useful
>>>           for debugging
>> 
>> Nice idea, I'll see it.  Can it be disabled (information leakage)?
> 
> There's not really any information leakage per-se, unless you call
> md5suming the url information leakage.

Ah, sorry, I send this comment before actually reading patch in question.

-- 
Jakub Narebski
Poland
