From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/7] lockfile: introduce alloc_lock_file() to avoid valgrind
 noise
Date: Sat, 02 Oct 2010 18:30:25 +0200
Message-ID: <4CA75E21.1090407@op5.se>
References: <wes62zknmki.fsf@kanis.fr> <7v1va760ip.fsf@alter.siamese.dyndns.org> <20100810032647.GA2386@burratino> <20101002082752.GA29638@burratino> <20101002083216.GC29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 18:30:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P24zA-0004el-Tj
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 18:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab0JBQac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 12:30:32 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49510 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753967Ab0JBQac (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 12:30:32 -0400
Received: from source ([209.85.215.172]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTKdeJpcceJU9xia6OFxugnL4pjkUXQ3n@postini.com; Sat, 02 Oct 2010 09:30:31 PDT
Received: by eyd10 with SMTP id 10so1483333eyd.3
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 09:30:30 -0700 (PDT)
Received: by 10.213.113.206 with SMTP id b14mr6778643ebq.33.1286037028785;
        Sat, 02 Oct 2010 09:30:28 -0700 (PDT)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id z55sm3866245eeh.15.2010.10.02.09.30.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 09:30:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <20101002083216.GC29638@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157807>

On 10/02/2010 10:32 AM, Jonathan Nieder wrote:
> 
> Add a alloc_lock_file() helper to make such tolerance easier.
> Allocations made through this helper function will not be reported as
> leaks by valgrind even if there is no corresponding free().  The
> ((optimize("-fno-optimize-sibling-calls"))) attribute is needed on
> platforms with GCC to ensure that the stack frame for
> alloc_lock_file() is not replaced by the stack frame for xcalloc().
> 

So we're basically increasing runtime to shut up a leakchecking tool
and also making that leakchecking tool falsely not report positives.
Hmm...

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
