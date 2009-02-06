From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 2/6] gitweb: feed generator metadata
Date: Fri, 6 Feb 2009 12:01:31 +0100
Message-ID: <cb7bb73a0902060301s2a2f81e2t1762377177fb550e@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902050015.20170.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOUA-00014U-H5
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbZBFLBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbZBFLBf
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:01:35 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:15898 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbZBFLBe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:01:34 -0500
Received: by ey-out-2122.google.com with SMTP id 25so205254eya.37
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 03:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9Rrb/fa34J0ZVSFpccEJbpkM7yqMhKav3cgMsNkYE1M=;
        b=brk1GashLkpyZxkXdRhGZDNg8KCE4+f4TbM9ptsTWk6bBS5tSeFs2ALyfTRhNWYb5W
         2JbabLsremrztiCgNYEhNbJM8Czc0iUCciFnLrRo12laQqtcmVBakTOu1Q9ZM5z0jmkF
         yQJAsVXdkZQ6rgpjwexdHm1iBXODa7PEdcGyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z/uFnb2rkwAzIU81/YmzfvVMvuZcYT5MLEu5D4dg6KlcmLpX9HH6L5GVwCyNmBfukT
         HObjZ+BC4a6AFF2IcB/vbTkfE9g0TncofiMR+sJJg4D93BaBZNJEQTxxdoe7d5OZy2YS
         AY2NqI6y5ZE4ps7BzYfkn+ehJ+aCeAyRkZz00=
Received: by 10.211.196.13 with SMTP id y13mr1202408ebp.171.1233918091925; 
	Fri, 06 Feb 2009 03:01:31 -0800 (PST)
In-Reply-To: <200902050015.20170.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108679>

On Thu, Feb 5, 2009 at 12:15 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:
>
>> Add <generator> tag to RSS and Atom feed. Versioning info (gitweb/git
>> core versions, separated by a literal slash) is stored in the
>> appropriate attribute for the Atom feed, and in the tag content for the
>> RSS feed.
>
> Very good idea. I haven't examined either specification, so I don't
> know what conventions are used, though... and what conventions _should_
> be used.
>
> By the way, gitweb uses in HTML header the following (see
> git_header_html subroutine):
>
>  <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
>
> which tries to follow convention how _web servers_ like Apache return
> version information in the 'Server:' HTTP response header (product
> tokens). Because it was used on only one place, it was not put into
> separate subroutine; should it now?

RSS 2.0 spec for generator @
http://cyber.law.harvard.edu/rss/rss.html#optionalChannelElements
seems to suggest that the content for the tag in RSS feeds is pretty
much free-form and we might use the same string we have in HTML pages.
Requirements for Atom (see
http://www.atomenabled.org/developers/syndication/atom-format-spec.php#element.generator
) are rather more stringent, so it needs its own code anyway.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>  gitweb/gitweb.perl |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index f8a5d2e..3d94f50 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -6085,6 +6085,7 @@ XML
>>                             "<link>$alt_url</link>\n" .
>>                             "</image>\n";
>>               }
>> +             print "<generator>gitweb v.$version/$git_version</generator>\n";
>>       } elsif ($format eq 'atom') {
>>               print <<XML;
>>  <feed xmlns="http://www.w3.org/2005/Atom">
>> @@ -6111,6 +6112,7 @@ XML
>>               } else {
>>                       print "<updated>$latest_date{'iso-8601'}</updated>\n";
>>               }
>> +             print "<generator version='$version/$git_version'>gitweb</generator>\n";
>
> I'd rather use '"' for attributes, i.e.
>
> +               print "<generator version=\"$version/$git_version\">gitweb</generator>\n";

I can do that.

-- 
Giuseppe "Oblomov" Bilotta
