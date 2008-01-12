From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Fri, 11 Jan 2008 23:34:34 -0800
Message-ID: <7vejcnwl85.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
	<200801120926.14307.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763302AbYALHe4@vger.kernel.org Sat Jan 12 08:35:40 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763302AbYALHe4@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDau2-0001GB-K6
	for glk-linux-kernel-3@gmane.org; Sat, 12 Jan 2008 08:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763302AbYALHe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 12 Jan 2008 02:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759732AbYALHeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jan 2008 02:34:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011AbYALHen convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jan 2008 02:34:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C24C348DB;
	Sat, 12 Jan 2008 02:34:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 25F8B48D9;
	Sat, 12 Jan 2008 02:34:37 -0500 (EST)
In-Reply-To: <200801120926.14307.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Sat, 12 Jan 2008 09:26:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70284>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> Saturday 12 January 2008 09:11:23 tarihinde Junio C Hamano =C5=9Funla=
r=C4=B1 yazm=C4=B1=C5=9Ft=C4=B1:
>> The third rc for the next feature release GIT 1.5.4 is available
>> at the usual places:
>>
>>   http://www.kernel.org/pub/software/scm/git/
>>
>>   git-1.5.4.rc3.tar.{gz,bz2}			(tarball)
>>   git-htmldocs-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
>>   git-manpages-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
>>   testing/git-*-1.5.4.rc3-1.$arch.rpm	(RPM)
>
> I am seeing new failures compared to rc2 :
>
> *** t9200-git-cvsexportcommit.sh ***
> * FAIL 1: New file
>         mkdir A B C D E F &&
>              echo hello1 >A/newfile1.txt &&
>              echo hello2 >B/newfile2.txt &&
>              cp ../test9200a.png C/newfile3.png &&
>              cp ../test9200a.png D/newfile4.png &&
>              git add A/newfile1.txt &&
>              git add B/newfile2.txt &&
>              git add C/newfile3.png &&
>              git add D/newfile4.png &&
>              git commit -a -m "Test: New file" &&
>              id=3D$(git rev-list --max-count=3D1 HEAD) &&
>              (cd "$CVSWORK" &&
>              git cvsexportcommit -c $id &&
>              check_entries A "newfile1.txt/1.1/" &&
>              check_entries B "newfile2.txt/1.1/" &&
>              check_entries C "newfile3.png/1.1/-kb" &&
>              check_entries D "newfile4.png/1.1/-kb" &&
>              diff A/newfile1.txt ../A/newfile1.txt &&
>              diff B/newfile2.txt ../B/newfile2.txt &&
>              diff C/newfile3.png ../C/newfile3.png &&
>              diff D/newfile4.png ../D/newfile4.png
>              )
> Ideas appreciated.

Often the first failure is the most interesting one.  Running
the test under sh -x like this:

	$ cd t
	$ sh t9200-git-cvsexportcommit.sh -i -v

and then looking at "trash" directory would tell you which one
of the long sequence of commands failed, and further
investigation can be made from there.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
