From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: Re: [PATCH 1/4] gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch
Date: Tue, 09 Apr 2013 23:59:47 +0200
Message-ID: <m28v4r9xgs.fsf@zahir.fritz.box>
References: <m2zjx8bxaj.fsf@blackdown.de>
	<7vd2u4vg4o.fsf@alter.siamese.dyndns.org> <5163FC2D.9050408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 00:00:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPgaQ-0007L5-PR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 00:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935868Ab3DIWAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 18:00:11 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:41110 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934324Ab3DIWAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 18:00:10 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so3905820bkc.30
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=DzOeor85tOiVohd8F2KeNMHGRbPC2TvDjk/ByfVN8Gk=;
        b=dILypCHQnfWl0IlSbbMRGw4DtAWe1bxLo4OCaTooqY9nsz8N8kT30DIqP44GjW3/Bn
         Vv/U3uuo9UTIy7t/xxPd9x9eLXtMKVFJRpIBOLAVd0lRuPqKv3ocroP1r1N1OhIBGR15
         wBnc/Ksw5wb1kmzBXmkgTsHySGXOD56ueVe4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=DzOeor85tOiVohd8F2KeNMHGRbPC2TvDjk/ByfVN8Gk=;
        b=fHs52ExVDvYtw9YjdoeHcyqGKm9BmOASzUSe2U7T5l3IgHY7G7ULSaP3P2FTerb1oh
         wVTVbAbVYMiXREJ3gxXQ4suGb0bY6ZEK3XSzk9zgBjC4NT2W2/1I7XE6sus3BpRsW9EY
         GD7fkThWGjQlo3ydQ54RIg1lzJuJr8m78Cy+iMtc1JFvP04qaltCaWgxPMhbFkaAgUkt
         vDlKjmAj3Ky2VJYHYhdi1HyAIekjHPKnkdISIZ+GKZWA54l5Sk7f2zswMxxu0MxiW4P3
         B9XvsJNw5dJgK1R2UQfF0xCPnjrVd7BmB0/RtqVN+mcT/QyZW2bldcVRzR8rU+mO4Bh3
         m3qw==
X-Received: by 10.204.200.139 with SMTP id ew11mr7729692bkb.70.1365544808245;
        Tue, 09 Apr 2013 15:00:08 -0700 (PDT)
Received: from zahir.fritz.box (p20030056CF2E81009227E4FFFEF3FF5E.dip.t-dialin.net. [2003:56:cf2e:8100:9227:e4ff:fef3:ff5e])
        by mx.google.com with ESMTPS id w6sm14668639bkz.17.2013.04.09.15.00.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 15:00:07 -0700 (PDT)
In-Reply-To: <5163FC2D.9050408@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Tue,
	09 Apr 2013 13:31:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQk760ofKBO3Algqqewv4CzbrmKGp5sI52BL1yJMv1A1sI6egBdrxkNz2SDTt0cxuLVq602S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220642>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On 08.04.2013, Junio C Hamano wrote:
>> jk@blackdown.de (J=C3=BCrgen Kreileder) writes:
>>=20
>>> Fixes the encoding for several _plain actions and for text/* and */=
*+xml blobs.=20
>>>
>>> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
>
> I see that this patch does (or tries to do) two _independent_ things,
> and should be split into at least two separate commits:

Agreed.

>>> ---
>>=20
>> Thanks, will queue but not hold until I hear something from Jakub.
>>=20
>>>  gitweb/gitweb.perl |    8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index 1309196..9cfe5b5 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -3823,7 +3823,7 @@ sub blob_contenttype {
>>>  	my ($fd, $file_name, $type) =3D @_;
>>> =20
>>>  	$type ||=3D blob_mimetype($fd, $file_name);
>>> -	if ($type eq 'text/plain' && defined $default_text_plain_charset)=
 {
>>> +	if (($type =3D~ m!^text/\w[-\w]*$! || $type =3D~ m!^\w[-\w]*/\w[-=
\w]*\+xml$!) && defined $default_text_plain_charset) {
>>>  		$type .=3D "; charset=3D$default_text_plain_charset";
>>>  	}
>
> First, it extends adding "; charset=3D$default_text_plain_charset" to
> other mimetypes for 'blob_plain' view to all 'text/*' and '*/*+xml'
> mimetypes (without changing name of variable... though this is more
> complicated as it is configuration variable and we would want to
> preserve backward compatibility, but at least a comment would be,
> I think, needed).
> =20
> Originally it applied only to 'text/plain' files, which can be
> displayed inline by web browser, and which need charset in
> 'Content-Type:' HTTP header to be displayed correctly, as they
> do not include such information inside the file.

What prompted the change is that some browsers (Chrome and Safari) also
display other file types inline: text/x-chdr, text/x-java, text/x-objc,
text/x-sh, ...

At least on my system these files do get served with charset set!
(ISO-8859-1 even though Apache has "AddDefaultCharset UTF-8"...)

    $ curl -I "https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3D=
blob_plain;f=3DClasses/ContactAlbum.h;hb=3DHEAD"
    HTTP/1.1 200 OK
    Date: Tue, 09 Apr 2013 21:47:30 GMT
    Server: Apache
    Content-disposition: inline; filename=3D"Classes/ContactAlbum.h"
    X-Frame-Options: SAMEORIGIN
    Vary: User-Agent
    X-UA-Compatible: IE=3Dedge
    Strict-Transport-Security: max-age=3D31536000
    Content-Type: text/x-chdr; charset=3DISO-8859-1

> 'text/html' and 'application/xhtml+xml' can include such information
> inside them (meta http-equiv for 'text/html' and <?xml ...> for
> 'application/xhtml+xml').  I don't know what browser does when there
> is conflicting information about charset, i.e. which one wins, but
> it is certainly something to consider.

As shown above, even without my patch, this already can happen!

> It might be a good change; I don't know what web browser do when
> serving 'text/css', 'text/javascript', 'text/xml' to client to
> view without media type known.
>
>
> BTW I have noticed that we do $prevent_xss dance outside
> blob_contenttype(), in it's only caller i.e. git_blob_plain()...
> which for example means that 'text/html' converted to 'text/plain'
> don't get '; charset=3D...' added.  I guess that it *might* be
> what prompted this part of change... but if it is so, it needs
> to be fixed at source, e.g. by moving $prevent_xss to
> blob_contenttype() subroutine.

Jep.

[...]

> Second it changes 'blobdiff_plain', 'commitdiff_plain' (which I think
> that should be abandoned in favor of 'patch' view; but that is
> a separate issue) and 'patch' views so they use binary-safe output.
>
> Note that in all cases (I think) we use
>
>    $cgi->header(
>      -type =3D> 'text/plain',
>      -charset =3D> 'utf-8',
>      ...
>    );
>
> promising web browser that output is as whole in 'utf-8' encoding.

Yes.

> It is not explained in the commit message what is the reason for this
> change.  Is it better handing of a situation where files being diff-e=
d
> being in other encoding (like for example in commit that changes
> encoding of files from legacy encoding such like e.g. iso-8859-2
> or cp1250 to utf-8)?

I do see encoding problems when comparing utf8 to utf8 files (i.e. no
encoding change).  For instance:
https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Dcommitdiff_pl=
ain;h=3Dcc4eaa64c2b399dd9bdbf1f67f6d621aa24df5f8

I don't claim to be an expert in Perl's utf8 handling but I guess this
because Perl's internal utf8 form differs from the normal utf8 out from
git commands.  Switching to :raw fixes that: We write plain utf8 (and,
as noted above, charset is set to utf8 already)

With the patch: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dcomm=
itdiff_plain;h=3Dcc4eaa64c2b399dd9bdbf1f67f6d621aa24df5f8

> But what about -charset =3D> 'utf-8'  then?

That's a good question.  I think I never tried git with anything beside=
s
ISO-8859-1 (rarely), UTF8 (mostly), and UTF16 (some Xcode files).
(UTF16 definitely causes problems for gitweb.)

> About implementation: I think after this change common code crosses
> threshold for refactoring it into subroutine, for example:
>
>   sub dump_fh_raw {
>   	my $fh =3D shift;
>
>   	local $/ =3D undef;
>   	binmode STDOUT, ':raw';
>   	print <$fh>;
>   	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
>
>   	return $fh;
>   }

OK.

I'll submit an updated patch for the second part ('blobdiff_plain',
'commitdiff_plain', and 'plain') tomorrow.

Not sure how to proceed with the 'blob_plain' issue.


    Juergen

=3D=3D=20
https://blackdown.de/
