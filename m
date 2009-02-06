From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 4/6] gitweb: rss channel date
Date: Fri, 6 Feb 2009 12:10:36 +0100
Message-ID: <cb7bb73a0902060310s3fa19788t7f4ad0d39928d77@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050024.43634.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOcz-0003gT-GU
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbZBFLKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbZBFLKi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:10:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:21969 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbZBFLKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:10:37 -0500
Received: by ey-out-2122.google.com with SMTP id 25so206125eya.37
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RBmP+GAYC+zeUY3/GATjQDXHhgBoY8nVJwZk0HAmkoc=;
        b=K16bsA86YAVQ4cF4BXNYf3EZCgGUYdbsbkipO+N27cuPBlJCQ8U/MOTFdAHDU6B7/f
         7HiKIOjg30RGQx+Yo8CtLrUcoI+64V73B26tNSARLEiLXlXIMfuHDL5PS+ex4j1mSUT3
         ini08tPZwCnVr62T5WMsjSzgZz7sXbacu8BV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dRbn+EnJJqF/1lYWtpLAB83FrLysSb/w5L8dWOjmjeCle18k2Q4bsrvx/33MOx2Ph5
         KcQxVBWc0ICQBtnovMnHdJkdT6ZzDTHER81P+RrKzGV7aBMebdLTAiotgsVRZYRmJXBm
         eJmjgFzEWGZS6LYAdE4+++IWZXwJeeipMQIeA=
Received: by 10.210.42.13 with SMTP id p13mr1232235ebp.87.1233918636113; Fri, 
	06 Feb 2009 03:10:36 -0800 (PST)
In-Reply-To: <200902050024.43634.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108683>

On Thu, Feb 5, 2009 at 12:24 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> The RSS 2.0 specifications defines not one but _two_ dates for its
>> channel element! Woohoo! Luckily, it seems that consensus seems to be
>> that if both are present they should be equal, except for some very
>> obscure and discouraged cases. Since lastBuildDate would make more sense
>> for us and pubDate seems to be the most commonly used, we defined both
>> and make them equal.
>
> Perhaps it would make sense to quote RSS 2.0 standard format here
> in the commit message, e.g.:
>
>  pubDate        The publication date for the content in the channel.
>  lastBuildDate  The last time the content of the channel changed.

That sort of spoils the very non-technical tone of the message, but
you're probably right 8-D

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>  gitweb/gitweb.perl |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index cc6d0fb..756868a 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -6087,6 +6087,10 @@ XML
>>                             "<link>$alt_url</link>\n" .
>>                             "</image>\n";
>>               }
>> +             if (%latest_date) {
>> +                     print "<pubDate>$latest_date{'rfc2822'}</pubDate>\n";
>> +                     print "<lastBuildDate>$latest_date{'rfc2822'}</lastBuildDate>\n";
>> +             }
>
> I think it is good approximation of intended meaning of those two
> elements.

However, this is still not perfect. While this is absolutely fine for
rss feeds that point at an explicit commit hash, rss feeds that point
to  a dynamic ref (some branch head or whatever) can get an
interesting but confusing situation:

A updates his local clone of the repo.

B gets the feed of the repo, which is not updated to include A changes.

A pushes.

B gets the feed: the dates are actually BEFORE the date he last
retrieved the feed, although they are after the date shown the last
time he retrieved the feed.

Ideally, when the rss is publishing a dynamic ref, we should as
buildDate (and as Last-modified: HTTP header!) the date when the ref
was changed (e.g. the date of the push). However, I couldn't really
think of a robust way of getting such a date, which is why I'm using
the commit date which is what comes closest.

-- 
Giuseppe "Oblomov" Bilotta
