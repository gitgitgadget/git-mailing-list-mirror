From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/33] refs: document do_for_each_ref() and do_one_ref()
Date: Tue, 16 Apr 2013 11:11:36 +0200
Message-ID: <516D15C8.2050500@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-4-git-send-email-mhagger@alum.mit.edu> <7vobdfwv7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 11:11:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1vV-0005fA-JT
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 11:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab3DPJLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 05:11:41 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:60969 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105Ab3DPJLk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 05:11:40 -0400
X-AuditID: 1207440f-b7f0e6d000000957-96-516d15cb090b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 98.5B.02391.BC51D615; Tue, 16 Apr 2013 05:11:39 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3G9Bbh0018115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 05:11:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vobdfwv7m.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqHtaNDfQ4NF3LYuuK91MFg29V5gt
	Vj6+y2zxo6WH2YHFo/39O2aPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74/vaBewF
	91krvh5uYm5gPMXSxcjJISFgIjF/92xWCFtM4sK99WxdjFwcQgKXGSW23L3KBOEcZ5K4sPMn
	WBWvgLbE4xfH2EFsFgFViQsTLzCB2GwCuhKLeprBbFGBMIlV65cxQ9QLSpyc+QRsm4iAmsTE
	tkNANgcHs0CMxLmrQiBhYQEfif9/njFC7FrOKHHy716w+ZwCZhIPJk0E62UW0JF41/eAGcKW
	l9j+dg7zBEaBWUhWzEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkp
	pZsYIQHNv4Oxa73MIUYBDkYlHt4A+ZxAIdbEsuLK3EOMkhxMSqK8FwVyA4X4kvJTKjMSizPi
	i0pzUosPMUpwMCuJ8KovByrnTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBw
	KEnwxokADRUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWp8MTBaQVI8QHvLQNp5
	iwsSc4GiEK2nGHU5Vl558ppRiCUvPy9VSpy3CqRIAKQoozQPbgUsfb1iFAf6WJh3JkgVDzD1
	wU16BbSECWjJgVXZIEtKEhFSUg2M2lv2vjJZsDDvtM3hiVr/pfZ0782I2pg263DlgXe3o28b
	Ptsn9iv2avQUjwvp8Zfze7eveeyTkS7vlv03u6UkarrHif2HDB79OWTy9PRvK5nE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221398>

On 04/15/2013 07:38 PM, Junio C Hamano wrote:
>> +/*
>> + * Call fn for each reference in the specified submodule for which the
>> + * refname begins with base.  If trim is non-zero, then trim that many
>> + * characters off the beginning of each refname before passing the
>> + * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
>> + * broken references in the iteration.
>> + */
> 
> Early termination due to "fn()" returning non-zero needs to be
> documented here, no?
> 
>>  static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,

Correct, thanks.  Will be fixed in re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
