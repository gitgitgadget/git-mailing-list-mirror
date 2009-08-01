From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: support to globally enable/disable a snapshot format
Date: Sat, 01 Aug 2009 11:09:57 -0700 (PDT)
Message-ID: <m3ljm3qud7.fsf@localhost.localdomain>
References: <8E0889CB-8A0A-45A5-AF34-9643D4EEFCEF@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark A Rada" <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Aug 01 20:10:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXJ2H-0006z4-J1
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 20:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbZHASJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 14:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbZHASJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 14:09:59 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:53834 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZHASJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 14:09:58 -0400
Received: by ey-out-2122.google.com with SMTP id 9so726720eyd.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:mime-version:content-type;
        bh=wD2QuQNiaEnLAlaRojARgmdxC9zyngVkzkXyoT1Z64Q=;
        b=fu8RTUNG2OmDKhe2C0f5ZcnRxO4T05wpIqtPmkMKNvbvoJihdK+nK2SYN4ZNs0dvsI
         3GXIcsLIClDD2rsRoe1X2uq+cDW9EYkjqsF/3yykkInCk9OkeVNn99Xzi00w9fibjGo+
         U6nVs6nJRnxkp1o03eEE+ABffHcPhmmu0A04M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:mime-version:content-type;
        b=kdY9ix8jMUkzg39nZHhIt0tiZBRWwwQYBkOYoNKPcujwXAN/ei3rDywbombLHwXgBq
         e8xsiWruJTEVa1Y5EIyOXUQ3EEGFe+xrGu7zM56EQR1b6r+mcszdUsH5KCQLtGNaQlQS
         g8NGqCPizMoH9LcMjOEAxxS5KtOz/7bYVAMKY=
Received: by 10.210.51.10 with SMTP id y10mr2675166eby.40.1249150197796;
        Sat, 01 Aug 2009 11:09:57 -0700 (PDT)
Received: from localhost.localdomain (abvt157.neoplus.adsl.tpnet.pl [83.8.217.157])
        by mx.google.com with ESMTPS id 5sm6130728eyf.8.2009.08.01.11.09.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 11:09:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n71I9PiN013444;
	Sat, 1 Aug 2009 20:09:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n71I98w2013440;
	Sat, 1 Aug 2009 20:09:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124642>

By the way, somehow [PATCH 2/2] doesn't look for me as if it was reply
to [PATCH 1/2] email...

Mark A Rada <marada@uwaterloo.ca> writes:
> On 1-Aug-09, at 4:14 AM, Jakub Narebski wrote:
>> "J.H." <warthog19@eaglescrag.net> writes:
>>
>>> Well you can always call xz with -[1-9] to change the compression
>>> level (same as gzip and bzip2) though I think a full disabling would
>>> be 'more' preferable, though I'm not sure I like Jakub's suggestion
>>> of just deleting it after the fact, it would work.
>> [...]
>>
>> The problem is that 'keys %known_snapshot_formats' serves also as list
>> of allowed snapshot formats, if project specific override is enabled.
>> We can add another optional flag ('disabled' => 1) if you don't want
>> to delete from %known_snapshot_formats in $GITWEB_CONFIG, though I
>> don't know if it is worth it.  Anyway such mechanism can be added, and
>> IMHO should be added, in a separate commit.
> 
> Is this correct?

Thanks for doing it.

It is correct, although I had in mind slightly different solution

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3398163..0a9cec6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -167,27 +167,31 @@ our %known_snapshot_formats = (
>   	'txz' => {
>   		'display' => 'tar.xz',
>   		'type' => 'application/x-xz',
>   		'suffix' => '.tar.xz',
>   		'format' => 'tar',
> -		'compressor' => ['xz']},
> +		'compressor' => ['xz'],
> +		'enabled' => 1},

I'd rather use here, taking for example 'txz' as "known but disabled"

  +		'compressor' => ['xz'],
  +		'disabled' => 1},


>   	'zip' => {
>   		'display' => 'zip',
>   		'type' => 'application/x-zip',
>   		'suffix' => '.zip',
> 		'format' => 'zip'},
>   );

And then you would not need to modify the rest of snapshot formats,
making use of the fact that $hash{'key'} is false-ish, if 'key' does
not exist in hash.

Also, this should be documented at least in comments.
 
>   # Aliases so we understand old gitweb.snapshot values in repository
> @@ -5171,6 +5175,8 @@ sub git_snapshot {
>   		die_error(400, "Unknown snapshot format");
>   	} elsif (!grep($_ eq $format, @snapshot_fmts)) {
>   		die_error(403, "Unsupported snapshot format");
> +	} elsif (!$known_snapshot_formats{$format}{'enabled'}) {
> +		die_error(403, "Snapshot format not allowed");

This would be modified then to read:

  +	} elsif ($known_snapshot_formats{$format}{'disabled'}) {
  +		die_error(403, "Snapshot format not allowed");

Also, we want not only protect againts *using* known but disabled
format, but also do not display it as one of formats available, even
if project specific override is supprted for snapshot, and projects
list it in gitweb.snapshot:

@@ -509,7 +509,8 @@ sub filter_snapshot_fmts {
 		exists $known_snapshot_format_aliases{$_} ?
 		       $known_snapshot_format_aliases{$_} : $_} @fmts;
 	@fmts = grep {
-		exists $known_snapshot_formats{$_} } @fmts;
+		exists $known_snapshot_formats{$_} &&
+		!$known_snapshot_formats{$_}{'disabled'} } @fmts;
 }
 
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";


-- 
Jakub Narebski
Poland
ShadeHawk on #git
