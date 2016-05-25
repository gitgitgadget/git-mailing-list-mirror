From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix link to parent diff with pathinfo
Date: Wed, 25 May 2016 22:33:32 +0200
Message-ID: <CANQwDwdKaVDGDxZZma25WcV+ea90YtFhDedLwv2KNZt6jhKVAQ@mail.gmail.com>
References: <xmqqmvo225fg.fsf@gitster.mtv.corp.google.com> <1462579902-18907-1-git-send-email-rbraun@sceen.net>
 <xmqq37p75nif.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Braun <rbraun@sceen.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 22:34:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5fVU-00015i-1L
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 22:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbcEYUeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 16:34:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36784 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEYUeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 16:34:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id q62so19073165wmg.3
        for <git@vger.kernel.org>; Wed, 25 May 2016 13:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3HL+cGHdCrzUakZ0w3wrXYxXhZyHDRrUmJ5x3uI8uZc=;
        b=AL2hcn4S8fG0IwGgpQNDQgSZlNp78Owb+B34pig3OOb5mt6eeYK7z4ufv5Vho0DBwr
         9G9x99I1tCJMFsSQqv5TOutGMzteiFEHEmsng3+832Jwgk0WXpsMQhIy9VVb4XQtPIVo
         HU9pRg5HwDiJ5j5y0rx2s7xEXdmLfUCRjBuxI9WhV6kxcqH69VDG1sQFNBfG238pEg/z
         FLcpFIupoWPuZ/CBKbrWRym/ls9b67cTDTDlr496XCFmjkAHzlGzp8I/5lLWyL86U2wM
         ZHwpAE4jQ8NqZQGsmBwGcOncpTelhPvybzyuCGTHfU7dtqsLYYnMg1youC1adDMXW4FP
         IZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3HL+cGHdCrzUakZ0w3wrXYxXhZyHDRrUmJ5x3uI8uZc=;
        b=GmIHLUReAoG7CtWOpNPa9oKC6yGijiCIPzJD8hVRHN+qf7L6QPPUkwEYOPYvU9KIbV
         WUo0VcXZkajRtoHKKuKdbPPJVC87Cg8eVtgyxutHSB7PHd8PQGBPQLMEPMBpSTyXVoA+
         W/LTHyCB8QdW9RXCwdpnvjoXaWf4CxGENfTrNl7ShoxfPz0zWgKPSISqFfjSYHykw/GK
         pQbMrVuoSdpYefRHTUIDWbHSQ+HfdKpKnjxkFmRvHIPXBB4m/d5GIxLCs7dLDyg4UFug
         l0MWAirk6wmS3Shhj77UVvqXlgKOrzbyVHJyNkUnAhaR8buZRWzwr/HHHdz/ROq8NxMw
         3LSA==
X-Gm-Message-State: ALyK8tK7FB2KUpo2JxY50pq9WSOw32ucMGJgEt2Huw5pokMipDwh8FqzPnR5Fp2CfWkgF5q8nRf/sEBJC/RrXA==
X-Received: by 10.194.171.7 with SMTP id aq7mr5487786wjc.8.1464208451750; Wed,
 25 May 2016 13:34:11 -0700 (PDT)
Received: by 10.194.124.129 with HTTP; Wed, 25 May 2016 13:33:32 -0700 (PDT)
In-Reply-To: <xmqq37p75nif.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295588>

On Tue, May 24, 2016 at 8:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Richard Braun <rbraun@sceen.net> writes:
>
>> Gitweb, when used with PATH_INFO, shows a link to parent diff
>> like http://somedomain/somerepo.git/commitdiff/somehash?hp=parenthash.
>> That link reports "400 - Invalid hash parameter".

Richard, at which view is this bad link present? Err... never mind, I see that
gitweb uses link to 'commitdiff' view with 'hash_parent' parameter set only
..in two places (well, perhaps there are some which get hash_parent from
-replay, but I doubt it): the "commit" view (link to each parent commit)
and in "commitdiff" view for octopus merges (e.g. "pu" in git.git).

The problem is not with ?hp=parenthash, but with /somehash part, which
somehow got invalid (from the error message). I have checked using
http://repo.or.cz/git.git, and while it has the bug (i.e. uses '?hp=...' instead
of path_info), there is no "400 - Invalid has parameter" error.

>> As I understand it, it should instead directly point to the parent diff,
>> i.e. turn it into http://somedomain/somerepo.git/commitdiff/parenthash,

Actually, the correct path_info based URI would be

  http://somedomain/somerepo.git/commitdiff/parenthash..somehash

Just like href() does with hash_parent_base and hash_base for blobdiff.
Urgh... href() is a bit of mess, now I see it when I am not current.

>> and delete 'hash_parent' element from the %params hash once we used it,
>> otherwise the '?hp=parenthash' string is appended.

That's correct: the unstated rule of href is that if it went into path_info,
it is deleted (not everything can be expressed with path_info), the rest
goes into query parameters. So without deleting the element, it would
be duplicated.

Note that using query parameter when we can use path_info is a minor
error; URL should work anyway (and I don't see why it doesn't - somewhat
the 'hash' parameter got incorrect...).

>>
>> Signed-off-by: Richard Braun <rbraun@sceen.net>
>> ---
>
> Pinging...

I'm sorry, I didn't notice it was meant for me. Simple "Jakub,..."
would be enough.

On Tue, May 24, 2016 at 8:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Richard Braun <rbraun@sceen.net> writes:
>
>> On Tue, May 24, 2016 at 11:17:28AM -0700, Junio C Hamano wrote:
>>> Pinging...
>>
>> Hum, see [1].
>>
>> Tell me if I need to resend.
>
> Sorry, check the "To:" field of the message you are responding to.
> The ping was not meant to (and was not addressed to) you.  It asked
> for comments from an area expert.

Only this made me realize that you are expecting *my* response.

>>  gitweb/gitweb.perl | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 05d7910..f7f7936 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1423,7 +1423,12 @@ sub href {
>>                       delete $params{'hash'};
>>                       delete $params{'hash_base'};
>>               } elsif (defined $params{'hash'}) {
>> -                     $href .= esc_path_info($params{'hash'});
>> +                     if (defined $params{'hash_parent'}) {
>> +                             $href .= esc_path_info($params{'hash_parent'});
>> +                             delete $params{'hash_parent'};
>> +                     } else {
>> +                             $href .= esc_path_info($params{'hash'});
>> +                     }

This should read _something_ like this

+                     if (defined $params{'hash_parent'}) {
+                             $href .=
esc_path_info($params{'hash_parent'}) . '..';
+                             delete $params{'hash_parent'};
+                     }
+                     $href .= esc_path_info($params{'hash'});
+                      delete $params{'hash'};

Otherwise you would get correct link in your situation with
bad 'hash' parameter, but not the view that was requested;
it would not be diff between current and given parent, but
commitdiff for parent (to grandparent(s)).

Richard, thanks for finding a problematic thing, but you
need to search more for a true fix.

Regards
-- 
Jakub Narebski
