From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 20:00:17 +0200
Message-ID: <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
	 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
	 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
	 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 20:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myr6K-0003kJ-Lj
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 20:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbZJPSAQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZJPSAP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 14:00:15 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:64976 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZJPSAO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 14:00:14 -0400
Received: by fxm18 with SMTP id 18so2707448fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uVQ+eQYkW78+qbbBgb+eFPoRCRUNBfiK/WRRmpu8etw=;
        b=Xd1fM00ZwMUns6NG8XTY00kMHsRLsxINT9OMc+N6HLDFOruKfJQIcMFIfR3fs5rxvc
         oDFWqm5TDBGxc0ZWZiBA7QjlPDV44ADqGgM/jOXlEQfjYdLUszOGvG626gljkS9W+x6a
         EZ7C3MGtaxk1yDzLOTcOH5KfnfXs3PBTzrcBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F4FKRqbC9cyMYyv46N8GKg7FdoPoXocupVSx8eydfCieryQ8ylO2qwpkB4zkOWAlkZ
         4YssnP+mDo2+TIkU5oYJo2Wd8b35FVZPOydE81geDQmvjoOWTdpgdxLnC3YepkD7pD3D
         QYyT2NjVmP2VLQATqR+Am20hPZy/ns/r5gWNk=
Received: by 10.204.174.209 with SMTP id u17mr1625698bkz.7.1255716017629; Fri, 
	16 Oct 2009 11:00:17 -0700 (PDT)
In-Reply-To: <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130516>

On Fri, Oct 16, 2009 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Then I would make modified "texts" from the blob of the file in the
>> current revision and its parent revision, by inserting newlines afte=
r
>> every single byte (probably replacing the original newlines by other
>> values, such as \x01).
>>
>> The reason for this touchup is that the diff machinery in Git only h=
andles
>> line-based diffs.
>>
>> Then you can parse the hunk headers, adjust the offsets accordingly,=
=2E..
>
> I would agree that text converted to "byte-per-line" format would be =
the
> easiest way to re-use the diff engine, but if you go one more step, y=
ou
> can even reusel the blame engine as well. =A0You convert the text int=
o
> "byte-in-hex-and-lf" (e.g. "AB C\n" becomes "41\n42\n20\n43\n0a\n") a=
nd
> feed it into existing blame and have it produce script-readable outpu=
t,
> instead of feeding that to your reinvention of blame using diff engin=
e.
>
> You would need to postprocess the computed result (either by diff or
> blame) to lay out the final text output in either case anyway, and ma=
king
> the existing blame engine do the work for you would be a better appro=
ach,
> I think.

Please can you tell me what is the basic algorithm of the blame engine?
I will have to start reading code
How can it tell the author a given line and I like the idea of one
line per char, even the newlines would be encoded that way. If it is a
unicode char, it might be multibyte.

The script would get the blame per byte and then recode that into
something visible.

od the octal dump utility comes to mind,
od x1 -w1 will output the file in one byte widths.

Now what about the ability to just pipe the file via some tool and
then run blame on that. It would just start the line with the byte
offset and blame would emit the blame for that offset and emit the
text that is following it.

so for example :
od x1 -w1  somefile :
///////////////////////////////
Offset       value
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D
0052752 065347
0052754 030356
0052756 035741
0052760 136302
0052762 035346

Here we see the lines are 0052760 - 0052762 =3D2  apart.

and then if you want wider diffs :
od some file
////////////////////////////////////////////
Offset       values
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D
0074520 051754 162613 057705 155520 047032 043654 175550 062704
0074540 164400 060340 123434 030350 040457 136010 042270 170525
0074560 165053 124677 125776 031370 000006 102076 060060 052434
0074600 176452 140240 074007 130113 100424 020010 130773 103467
0074620 052776 052421 021544 101357 120035 107562 072641 053636

Here we see the lines are 0074520 - 0074540   =3D 20 apart.

That way the blame tool will not be concerned with the formatting or
content, the users can write filters like they want, and blame would
only expect a byte offset...

That way, we could write something like this :
grep -b x Test.xml
0:<?xml version=3D"1.0" encoding=3D"UTF-8"?>
39:<gpx
107:  xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
then we would get blames for those byte offsets, very simple.

We could reduce this down to : make blame take a  list of byte position=
s.
grep -b \n Test.gpx would be the standard behavior, emit the blame per =
newline.

mike
