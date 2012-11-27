From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Third try at documenting command integration requirements.
Date: Tue, 27 Nov 2012 12:49:53 +0100
Message-ID: <50B4A8E1.7050801@alum.mit.edu>
References: <20121126053557.E56434065F@snark.thyrsus.com> <7vzk24qgjx.fsf@alter.siamese.dyndns.org> <20121126214134.GA1713@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 12:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdJg4-0004Kf-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 12:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab2K0Lt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 06:49:58 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:48099 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750890Ab2K0Lt5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 06:49:57 -0500
X-AuditID: 12074413-b7f786d0000008bb-ad-50b4a8e4f7f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 95.45.02235.4E8A4B05; Tue, 27 Nov 2012 06:49:56 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qARBnsfO009134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 27 Nov 2012 06:49:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121126214134.GA1713@thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqPtkxZYAgyOH5C2ubvGx6LrSzWTR
	0HuF2YHZ4+IlZY9lXztZPD5vkgtgjuK2SUosKQvOTM/Tt0vgzvj+8CNLwQqeitmn1jI2MF7g
	7GLk5JAQMJG4uuoHK4QtJnHh3no2EFtI4DKjxMOpqV2MXED2cSaJ+3+msIAkeAW0Jd61/2AG
	sVkEVCWuTFsIZrMJ6Eos6mlmArFFBQIkFi85xw5RLyhxcuYToF4ODhEBYYljfWogYWYBa4kV
	rw+DlQsL+EvsmXqPEWJXO6PEzI/HwY7gFDCQWPd1PQtEg47Eu74HzBC2vMT2t3OYJzAKzEKy
	YhaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAlc4R2Mu07K
	HWIU4GBU4uE9sGRzgBBrYllxZe4hRkkOJiVR3qdLtgQI8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuF9shQox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4D21DKhRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtPQ3SzltckJgLFIVoPcWo
	y7FhffsTRiGWvPy8VClx3qMgRQIgRRmleXArYGnqFaM40MfCvE9AqniAKQ5u0iugJUxAS5Kv
	bwRZUpKIkJJqYFR237RzbtOXiULOiytOPNZV+KJxsKvr9l1OZ90gXm8f8Z+x/pqsV8q7lPju
	efxZuH/V3X877jUturu75emrjwfsa9ecfbH5ZL3wl5MibvXPf2p9MJKeZmlzSfK2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210558>

On 11/26/2012 10:41 PM, Eric S. Raymond wrote:
> The next things on my git to-do list are 
> [...]
> 2. Submit a doc patch containing guidelines that (a) Python scripts should
>    check for their floor version and error out gracefully if they won't
>    run with the host's interpreter, and (b) Python scripts sbould be
>    2.6-compatible.

OK, now let's discuss *which* minimum Python version that git should
support in the hypothetical new world...

Data point: Mercurial supports Python 2.4 - 2.7 with the following
explanation [1]:

    We will continue to support Python 2.4 as long as it doesn't
    present a significant barrier to development. Given that Python 2.5
    and later don't contain any features that we're dying to use, that
    may be a long time off. [...]

    We also will continue to support Python 2.x as long as there is a
    significant installed base in the form of Red Hat Enterprise Linux
    and Ubuntu LTS users. RHEL 5, which uses Python 2.4, will reach the
    end of the "production 2" portion of its lifecycle in Q1 2014 and
    the end of its regular lifecycle in 2017.

It would be a shame to leave RHEL 5 users behind if Python is used to
implement important git functionality.  Python 2.4 is missing some of
Python's shiny new features, but still quite OK.  What features would
you miss the most if we were to target Python 2.4 instead of 2.6?

Michael

[1] http://mercurial.selenic.com/wiki/SupportedPythonVersions

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
