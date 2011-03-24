From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/1] gitweb: javascript ability to adjust time based on timezone
Date: Fri, 25 Mar 2011 00:36:46 +0100
Message-ID: <201103250036.49662.jnareb@gmail.com>
References: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> <201103242119.40214.jnareb@gmail.com> <4D8BCE0D.3080504@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org,
	Junio Hamano <gitster@pobox.com>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:37:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2u5R-0007NE-0x
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 00:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934374Ab1CXXg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 19:36:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60084 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934354Ab1CXXg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 19:36:58 -0400
Received: by wya21 with SMTP id 21so474338wya.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6guNfmisPmzPCclH2hPg76AixsBngnltccJwrmRB8TM=;
        b=qXkWF1LMFDqYvAkEgBxLntf9W8IKq+oGmAZaRiCqk9hJiQzphcefTD8yBeftNekE4R
         PtrdGQnxTMXWkXSaeYp+TIghEvZUTSYUNlxGMix8Id9GnsTvEUP8Sp4xDkwIwiOsfgZw
         F4WRukNPmlezA/5R7s0WC2W8UpQ+96SK/DopM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Mb1rW/59fKeXKAlRGUjMFSIwiYJX33FS6rbU1Bsq9hU59hDiQpDKwME7Cmz2ywSBr2
         MoA/lE5DlpJEfvYnam9I/zMSXL8LXQ+apMlxqka2U6sUHlZYXS8GuPCMa0yHxoOOPGNf
         tV3EEGU7XCuTAdLSneAKW31dDBFBZ/a27P/Rs=
Received: by 10.227.9.20 with SMTP id j20mr68497wbj.116.1301009817027;
        Thu, 24 Mar 2011 16:36:57 -0700 (PDT)
Received: from [192.168.1.13] (abwk172.neoplus.adsl.tpnet.pl [83.8.234.172])
        by mx.google.com with ESMTPS id x1sm191156wbh.19.2011.03.24.16.36.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 16:36:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4D8BCE0D.3080504@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169955>

On Fri, 25 Mar 2011, J.H. wrote:
> On 03/24/2011 01:19 PM, Jakub Narebski wrote:
>> On Thu, 24 Mar 2011, Kevin Cernekee wrote:

>>> 4) IE6 does not seem to like ISO 8601 format:
>>>
>>> x = new Date("2011-03-09T03:29:09Z");
>>>
>>> This sets all fields to NaN.  I suspect that getTime() values
>>> (milliseconds since 1970-01-01) are more portable.
>> 
>> Do you mean using epoch in title attribute, or fallback to parsing
>> ISO 8601 UTC format with regexps?
> 
> Parsing it with regexps is doable if completely inelegant, that said
> this is Javascript...
> 
> Looky that MS provides Virtual PC images for compat testing for IE6
> http://www.microsoft.com/downloads/en/details.aspx?FamilyID=21eabb90-958f-4b64-b5f1-73d0a413c8ef&displaylang=en
> 
> Ok reading through the documentation I can find for MS and their
> Date.parse (
> http://msdn.microsoft.com/en-us/library/dctx55bc(v=VS7.1).aspx ) and
> some quick experimentation:
> 
> 2011-03-09 - breaks
> 2011/03/09 - works

I really don't like using '/' as a separator; not only this is not
ISO-8601, but it is easy to confuse with insane American way of
writing dates with MM/DD/YYYY (day in the middle).
 
> 2011/03/09T01:01:01  - works, sorta - the hour comes out as 10 vs. 01
> 2011/03/09 01:01:01  - works, hour is correct
> 2011/03/09 01:01:01Z - works and seems to get the TZ correct
> 2011/03/09T01:01:01Z - breaks

If it worked in all (or almost all) web browsers with

  2011-03-09 01:01:01Z - works and seems to get the TZ correct

then I would say go for it - this variant of ISO-8601 with ' ' instead
of 'T' to separate date part from time part is more human-readable.
 
> Not really sure what the "right" way to fix this is going to end up
> being.  Suppose our options are:
> 
> 1) Try and find a format that is generally accepted and parseable on all
> the browsers
> 2) Declare IE6 an unsupported browser
> 3) Trap what browser we are on and do a regex parsing of the string and
> do appropriate sets or a more verbose format that works everywhere

If web browser returned undefined value if they can't parse date, then
we could do regexp parsing based on this, not on user-string (which is
in most cases wrong solution).

> 4) Use a regex and sets for every browser.
> 5) Switch all the embedded times over to epochs in the title=""'s
> 
> 4 is probably the "most" right that I can see of those options, and
> avoids possible other browser inconsistencies with respect to date
> parsing.  I'm going to code that up (it shouldn't be terribly
> complicated), unless someone likes one of the other ideas better.
> Suppose we could even go down the more complicate microformat route and
> just write some code to parse that, just more complicated all the way
> around.

Right.

> 5 has the appeal that everything handles the epoch correctly, but it
> does have the downside of being less readable in the html code (and
> shifts us slightly further away from the accepted "standard" of the
> microcode formats)

Well, we could always use non-standard 'epoch' attribute, or something...
 
-- 
Jakub Narebski
Poland
