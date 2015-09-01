From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 1 Sep 2015 15:42:39 +0200
Message-ID: <523D2C52-893E-4A54-9DD1-2DDBCEA29960@gmail.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com> <1441059026-66814-2-git-send-email-larsxschneider@gmail.com> <xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 15:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWlpn-0002NR-Va
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 15:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbIANmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 09:42:44 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34477 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbIANmn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 09:42:43 -0400
Received: by wicjd9 with SMTP id jd9so33729486wic.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tCnXDxsDiVY3iDXvWF/41VC9/OnPU+k4fK+pe/QcroQ=;
        b=kJHLpJvHKI4M031ficRwTScXkFjKV2JK9vB8SYs1dIRmiIBXM8oXI1DBg/QhmBwyez
         tPhsJi+grMMlBm0t6lw+1kdiT2Hm4Zw3wWszQck8XdrIDHVp6cK5onDkLLhW62MZr7b5
         GO+qSYIJAqMS/mAXvcLGzSSRhAtAVEd6uqEQR24r/rKmKvfYQwoqxTAiBdetrM5AUONs
         bQ4k34XmVoOBXcghUBEnHvnDRrMT6KZIcNJbCPXJ0DZyuw2FsXgv4WkBVK5NVB6Hp+iH
         Z6JggnI0XoTT/hMlFCAcD+7AE2r/ozly9LIRc+6yMHM0P/AA9yeZU1E7DfgzYSaGvIR8
         bRhA==
X-Received: by 10.180.208.34 with SMTP id mb2mr3672917wic.88.1441114962128;
        Tue, 01 Sep 2015 06:42:42 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xs1sm27261247wjc.7.2015.09.01.06.42.40
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 06:42:41 -0700 (PDT)
In-Reply-To: <xmqqk2sbt5kv.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276979>


On 01 Sep 2015, at 01:13, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>=20
> Here is a space for you to describe what it does and why it is a
> good idea to have it.
How about this:

Perforce keeps the encoding of a path as given by the originating OS. G=
it expects paths encoded as UTF-8. Add an option to tell git-p4 what en=
coding Perforce had used for the paths. This encoding is used to transc=
ode the paths to UTF-8. As an example, Perforce on Windows uses =93cp12=
52=94 to encode path names.=20


>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/git-p4.txt        |  5 +++++
>> git-p4.py                       |  6 ++++++
>> t/t9821-git-p4-path-encoding.sh | 38 +++++++++++++++++++++++++++++++=
+++++++
>=20
> I'll move this to 9822, as 9821 is taken by another git-p4 test,
> while queuing.
OK. I wasn=92t sure how this is handled. Just for my understanding: As =
soon as a TC number is occupied in one of the official branches (master=
/next/pu/maint) then the next number should be used, right?

>=20
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index 82aa5d6..14bb79c 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -252,6 +252,11 @@ Git repository:
>> 	Use a client spec to find the list of interesting files in p4.
>> 	See the "CLIENT SPEC" section below.
>>=20
>> +--path-encoding <encoding>::
>> +	The encoding to use when reading p4 client paths. With this option
>> +	non ASCII paths are properly stored in Git. For example, the encod=
ing
>> +	'cp1252' is often used on Windows systems.
>> +
>=20
> Is this something that needs to be consistently given while
> interacting with the same P4 depot (in which case you may want to
> allow this to be given only once, record the value in the config and
> never allow it to be updated once it is set, or something)?
Good idea! I will add this. However, I really wonder why nobody tripped=
 over this rather obvious bug already.

@Luke: Can you double check my fix?


Two general questions:

(1) I saw that the path encoding fix is already on =93pu=94. What is mo=
re convenient for you? Do you want to get a [PATCH v4] with one commit =
including the changes mentioned above or do you want me to keep the v3 =
commit and add a v4 commit on top?

(2) Is there a CI setup for Git somewhere accessible on the Internet? H=
ow about building and testing Git on Travis (https://travis-ci.org/git/=
git)?

Thanks,
Lars
