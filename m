From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 21:14:54 +0200
Message-ID: <4F73632E.1060408@ira.uka.de>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>	<7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:14:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyJz-0003Tz-QN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab2C1TOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:14:11 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58514 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753377Ab2C1TOK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 15:14:10 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1SCyJl-0004sW-AJ; Wed, 28 Mar 2012 21:14:06 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1SCyJk-0006ZI-ON; Wed, 28 Mar 2012 21:14:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <vpqvclozr7e.fsf@bauges.imag.fr>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1332962046.859744000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194165>

On 28.03.2012 17:21, Matthieu Moy wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> I mildly suspect nobody would come up with a sane behaviour, but what
>> would I know...
>
> Designing a per-hunk behavior would clearly be very tricky.
>

I don't think it's that tricky:

For a conflicted file show any conflicted hunks first(!) and only 
provide the following options for them:
q - quit, do not stage...
d - do not stage this hunk nor any of the remaining hunks in the file
e - manually edit the current hunk
? - print help

and additionally the following three options:
b - choose the base version
< - choose our version
 > - choose their version

< and > correspond to the conflict markers, alternatives would be o and t

The user now has the option to remove the conflicts (through editing or 
choosing one of the versions) or abort adding the file.

The tricky part might be sorting the hunks so that conflicts are first 
(depending on how the code works now), choosing the right version in a 
hunk (the three new options) should be relatively easy.
