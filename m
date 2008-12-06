From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv3 2/2] gitweb: links to patch action in commitdiff and shortlog view
Date: Sat, 6 Dec 2008 14:25:20 +0100
Message-ID: <cb7bb73a0812060525k65a7f549l2cce5f0dae9fc76c@mail.gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228345188-15125-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812060153.52947.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:28:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8xCc-00055o-AR
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 14:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbYLFNZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 08:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYLFNZW
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 08:25:22 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:10578 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbYLFNZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 08:25:22 -0500
Received: by ik-out-1112.google.com with SMTP id c29so332368ika.5
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 05:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mZbHJcFLb4cEwt63+tUhWbygAXtfdBCIy/2KqlDZ0FM=;
        b=xaJp3tcMUajLmDu0auj/8ZrXFfia4zKlDovxvC2bjBj+KOHNXFt3OiCW5Je44qezmg
         IkvmfEFCz6JJcBVOLPwuamigoVXcIMgrvcaE56Mt5AIr6p/eux1OFWPTtYkoCjlXnj26
         sdBYEDcJ2vZ5X6V34osPGdZ6SSXVy14wtvm4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IrsjK6aKEa/RmCh+lcq9sfarbEUrMS9PiOceoBOsCIwEecrsmmx3qrjhm2tDJIUrS6
         3nnPEDYFCgSIJM0Edl1lsoPqtAaJPxQO61fvmA0rdhZodSlobApRXnLMC2xJjT4TP49O
         Pz+HVqmI9xfWnta9+U/zp3zxnuba/6C56+yP0=
Received: by 10.210.34.5 with SMTP id h5mr1223928ebh.133.1228569920323;
        Sat, 06 Dec 2008 05:25:20 -0800 (PST)
Received: by 10.210.79.12 with HTTP; Sat, 6 Dec 2008 05:25:20 -0800 (PST)
In-Reply-To: <200812060153.52947.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102455>

On Sat, Dec 6, 2008 at 1:53 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>
>> In shortlog view, a link to the patchset is only offered when the number
>> of commits shown is less than the allowed maximum number of patches.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

>> +     if (gitweb_check_feature('patches')) {
>> +             $formats_nav .= " | " .
>> +                     $cgi->a({-href => href(action=>"patch", -replay=>1)},
>> +                             "patch");
>> +     }
>>
>>       if (!defined $parent) {
>>               $parent = "--root";
>> @@ -5415,6 +5420,11 @@ sub git_commitdiff {
>>               $formats_nav =
>>                       $cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>>                               "raw");
>> +             if ($patch_max) {
>> +                     $formats_nav .= " | " .
>> +                             $cgi->a({-href => href(action=>"patch", -replay=>1)},
>> +                                     "patch");
>> +             }
>>
>>               if (defined $hash_parent &&
>>                   $hash_parent ne '-c' && $hash_parent ne '--cc') {
>
> In the above two hunks 'patch' view functions as "git show --pretty=email"
> text/plain equivalent, but this duplicates a bit 'commitdiff_plain'
> functionality.  Well, 'commitdiff_plain' has currently some errors,
> but...

All things considered, for single commit view there is (modulo bugs)
no factual difference between plain diff and patch view.

Although we could merge them, I'm thinking that the plain diff view
has somewhat too much information in it. For backwards compatibility
it's probably not wise to change it, but we should consider it for the
next major version, honestly.

>> @@ -5949,6 +5959,14 @@ sub git_shortlog {
>>                       $cgi->a({-href => href(-replay=>1, page=>$page+1),
>>                                -accesskey => "n", -title => "Alt-n"}, "next");
>>       }
>> +     my $patch_max = gitweb_check_feature('patches');
>> +     if ($patch_max) {
>> +             if ($patch_max < 0 || @commitlist <= $patch_max) {
>> +                     $paging_nav .= " &sdot; " .
>> +                             $cgi->a({-href => href(action=>"patch", -replay=>1)},
>> +                                     @commitlist > 1 ? "patchset" : "patch");
>> +             }
>> +     }
>
> Here 'patch' view functions as "git format-patch", able to be downloaded
> and fed to git-am.  Perhaps the action should also be named 'patches'
> here?; it could lead to the same function.

I had half an idea to do so. 'patches' or 'patchset'?

> By the way, there is subtle bug in above link. If shortlog view is less
> than $patch_max commits long, but it is because the history for a given
> branch (or starting from given commit) is so short, and not because
> there is cutoff $hash_parent set, the 'patchset' view wouldn't display
> plain text equivalent view, but only patch for top commit.

Ah, good point.

Hm, not easy to solve. One way could be to add the hash_parent
manually. Or we could make the 'patches' view different from the
'patch' view in the way it handles refspecs without ranges. I'm
leaning towards the latter. What's your opinion?

> I assume that the link is only for 'shortlog' view, and not also for
> 'log' and 'history' views because 'shortlog' is the only log-like view
> which support $hash_parent?

The actual reason is that I never use log nor history view, but since
they don't support hash_parent because of this (I was the one who sent
the patch to support hash_parent in shortlog view) you could
paralogistically say that's the reason ;-)

I'm not sure about history view, but for log view I'm considering
addiong also a 'patch' link next to each commit. I'll think about it.

-- 
Giuseppe "Oblomov" Bilotta
