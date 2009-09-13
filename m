From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [RFC/PATCH v4 1/2] gitweb: check given hash before trying to
 create snapshot
Date: Sun, 13 Sep 2009 01:37:37 -0400
Message-ID: <4AAC8521.1060005@mailservices.uwaterloo.ca>
References: <4AAC3833.8060905@mailservices.uwaterloo.ca> <7vmy4z4j35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 07:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmhmw-0006v1-Aq
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 07:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZIMFhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 01:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbZIMFhr
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 01:37:47 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:48299 "EHLO
	mailchk-m03.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750867AbZIMFhr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 01:37:47 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m03.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8D5bbBO021135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Sep 2009 01:37:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <7vmy4z4j35.fsf@alter.siamese.dyndns.org>
X-UUID: 12357783-df15-4086-b6c8-70befeb8cdc8
X-Miltered: at mailchk-m03 with ID 4AAC8521.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m03
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m03.uwaterloo.ca [129.97.128.141]); Sun, 13 Sep 2009 01:37:46 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128335>

On 09-09-12 11:30 PM, Junio C Hamano wrote:
>> @@ -5196,8 +5202,9 @@ sub git_snapshot {
>>  		die_error(403, "Unsupported snapshot format");
>>  	}
>>  
>> -	if (!defined $hash) {
>> -		$hash = git_get_head_hash($project);
>> +	my $full_hash = git_get_full_hash($project, $hash);
>> +	if (!$full_hash) {
>> +		die_error(404, 'Hash id was not valid');
>>  	}
> 
> This is in the context of "snapshot", so obviously you care more about
> just "such an object exists", don't you?  You also want it to be a
> tree-ish.  Try giving it $hash = 'junio-gpg-pub' and see how it breaks.
 
You have confused me. How is using 'junio-gpg-pub' different from the 
second test case that tries to use 'frizzumFrazzum'?


-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca
