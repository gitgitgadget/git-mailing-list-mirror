From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/5] replace: forbid replacing an object with one of a
 different type
Date: Sun, 25 Aug 2013 21:44:17 +0200 (CEST)
Message-ID: <20130825.214417.1308749312477487067.chriscool@tuxfamily.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org>
	<20130825130609.4681.25786.chriscool@tuxfamily.org>
	<521A4E83.9000400@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, philipoakley@iee.org,
	trast@inf.ethz.ch
To: j6t@kdbg.org
X-From: git-owner@vger.kernel.org Sun Aug 25 21:44:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDgEv-0001tI-4t
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 21:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab3HYTol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 15:44:41 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:55977 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755973Ab3HYTok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 15:44:40 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 53A514E;
	Sun, 25 Aug 2013 21:44:18 +0200 (CEST)
In-Reply-To: <521A4E83.9000400@kdbg.org>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232963>

From: Johannes Sixt <j6t@kdbg.org>

> Am 25.08.2013 15:06, schrieb Christian Couder:
>> @@ -100,6 +101,15 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>  	if (check_refname_format(ref, 0))
>>  		die("'%s' is not a valid ref name.", ref);
>>  
>> +	obj_type = sha1_object_info(object, NULL);
>> +	repl_type = sha1_object_info(repl, NULL);
>> +	if (obj_type != repl_type)
>> +		die("Objects must be of the same type.\n"
>> +		    "Object ref '%s' is of type '%s'\n"
> 
> Is it really an "Object ref", not just an "Object"?

Well, it is what is passed to the command line. It is then converted into an
hex sha1 using get_sha1() and then sha1_to_hex().

What about:

     		die("Objects must be of the same type.\n"
		    "'%s' points to a replaced object of type '%s'\n"
		    "while '%s' points to a replacement object of type '%s'.",

> BTW, I appreciate your choice of where in the sentence the line breaks are.

Thanks,
Christian.
