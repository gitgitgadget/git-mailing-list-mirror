From: =?ISO-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>
Subject: Re: co-authoring commits
Date: Thu, 18 Jun 2015 23:25:44 +0200
Message-ID: <55833758.6010000@gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>	<xmqq4mm66r99.fsf@gitster.dls.corp.google.com>	<CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>	<20150617205931.GB24079@cloud>	<xmqqegla57hl.fsf@gitster.dls.corp.google.com>	<20150617222828.GB24438@cloud> <xmqq381q551o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>, josh@joshtriplett.org
X-From: git-owner@vger.kernel.org Thu Jun 18 23:26:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hK5-0005ZJ-6j
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbbFRV0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 17:26:05 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38816 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbFRV0C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:26:02 -0400
Received: by wibdq8 with SMTP id dq8so1202809wib.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/bKV7H2UuBHOMEhi9NaO4CsQLoYDfBGjKqB1O6yUBMQ=;
        b=UqDEmaxuLYbFqrzs3zRAyrV9nTZi37nka0ynbgRgQ/fytbCcuhYfc/hNREPH5Twz3A
         38WyYOgdq5zFwrb8fNsYqLDYNUjKaxN+5KHZRf2Mpxx0LXlPZhFySoNsrMWll23t61la
         aiu7c+IfN2SbMUFINSyFU+yAoHvM+DcKyxoktryNnbGyJNJYhGdbeSihFKuslw8RRwXV
         fGbWX6ZNFNTLmPgN/LwZJmDgMNxbYAX6Zt8EZJKgUwSyrsibR0iY9hrn5B15Zj/RyywP
         +NUww8OUww4FIOfl7T2pARmt1mvw63Y/72kAMWqL5OLIpza2oF0i2lNryf87cD249xtT
         Dyjg==
X-Received: by 10.180.109.6 with SMTP id ho6mr176611wib.58.1434662760917;
        Thu, 18 Jun 2015 14:26:00 -0700 (PDT)
Received: from [192.168.1.53] (ewv187.neoplus.adsl.tpnet.pl. [83.20.245.187])
        by mx.google.com with ESMTPSA id gz3sm5827681wib.0.2015.06.18.14.25.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2015 14:25:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqq381q551o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272078>

Junio C Hamano wrote:
> josh@joshtriplett.org writes:
>
>> Author and committer are used by many git tools; if they weren't par=
t of
>> the object header, they'd need to be part of some pseudo-header with=
 a
>> standardized format that git can parse.
>
> Yes, the same goes to the address on Signed-off-by: footers.  There
> recently was a series to enhance the footer list handling (Christian
> Cc'ed) for the generation and maintenance side, and I do think it is
> reasonable to further add enhanced support for footers.
>
> That does not argue for having a new "coauthor" as a new commit
> object header at all, though.

The threshold for modifying commit object is high. This is an
ABI-level change, something to do if there is no other solution.

Author and committer include datetime in the contents of the
field, which is used by Git for heuristics limiting walk. Coauthor
would have the same date as author, isn't it? If, after long
and involved discussion, we didn't add 'generation' field (for
easier cutting history walking), what chance adding 'coauthor'
has.

OTOH it would be nice to have support for .mailmap, and for
grepping... but the former could conceivably be added to the trailer
tool, the latter can be done with appropriate regexp in
"git log --grep=3D...".

I wonder what would break if one used 'Name <e@mai.l>, Name <em@i.l>'
as the author...

--=20
Jakub Nar=EAbski
