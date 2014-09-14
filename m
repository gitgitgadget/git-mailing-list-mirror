From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 11/32] delete_ref_loose(): don't muck around in the
 lock_file's filename
Date: Sun, 14 Sep 2014 08:27:10 +0200
Message-ID: <5415353E.8060907@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu> <1409989846-22401-12-git-send-email-mhagger@alum.mit.edu> <5413F51E.3060600@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Torsten_B=F6ger?= =?ISO-8859-15?Q?shausen?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Sep 14 08:27:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT3HN-0002nQ-H8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 08:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbaING1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 02:27:15 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:60305 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752353AbaING1O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2014 02:27:14 -0400
X-AuditID: 12074412-f792e6d000005517-97-541535410c2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BC.2B.21783.14535145; Sun, 14 Sep 2014 02:27:13 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2CD3.dip0.t-ipconnect.de [93.219.44.211])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8E6RAbZ008510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 14 Sep 2014 02:27:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <5413F51E.3060600@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsUixO6iqOtoKhpisGWxrkXXlW4mi4beK8wW
	T+beZbb40dLDbNHZ8ZXRgdXj4asudo9nvXsYPS5eUvb4vEnO4/azbSwBrFHcNkmJJWXBmel5
	+nYJ3BmNV58wFrSzVrzt/s/YwNjC0sXIySEhYCKx7MVKZghbTOLCvfVsXYxcHEIClxklTq87
	ygrhnGeSWNbYxgRSxSugLfHv3y82EJtFQFXi0bU9YHE2AV2JRT3NYLaoQIDEh84HjBD1ghIn
	Zz4B2yYioCBxYN9CsKHMAtsZJe5NmgSWEBZIlNg7dR3U6lmMEnfW3ga7iVNAQ+LPrHlAkziA
	OnQl2tbIgISZBeQlmrfOZp7ACFSMsGMWQtUsJFULGJlXMcol5pTm6uYmZuYUpybrFicn5uWl
	Fuma6eVmluilppRuYoQEudAOxvUn5Q4xCnAwKvHwBpwXDhFiTSwrrsw9xCjJwaQkytuqKhoi
	xJeUn1KZkVicEV9UmpNafIhRgoNZSYT3/UORECHelMTKqtSifJiUNAeLkjjvz8XqfkIC6Ykl
	qdmpqQWpRTBZGQ4OJQleExOgoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgWI0v
	BkYrSIoHaO8/Y6B23uKCxFygKETrKUZjjpamt71MHOs6v/UzCbHk5eelSonzBoJsEgApzSjN
	g1sES2+vGMWB/hbmLQSp4gGmRrh5r4BWMQGtejdHCGRVSSJCSqqBcZVW84tKK45zk338OFXr
	/kg/0LS/1+7UZs+wQ9bb3H/tQT6jZ6a/d06fdIdNhv3DV9nWu0/vhFTPtIhcwPbx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256995>

On 09/13/2014 09:41 AM, Johannes Sixt wrote:
> Am 06.09.2014 um 09:50 schrieb Michael Haggerty:
>> It's bad manners.  Especially since, if unlink_or_warn() failed, the
>> memory wasn't restored to its original contents.
> 
> I do not see how the old code did not restore the file name. Except for
> this nit, the patch looks good.

Hmmmm, you're quite right. I thought I had found some circumstance in
which unlink_or_warn() could fail to allocate memory and die() or
something. But I can't find anything like that now.

I will remove that sentence from the commit message.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
