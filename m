From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v8 1/2] add `config_set` API for caching config-like files
Date: Tue, 15 Jul 2014 16:24:17 +0530
Message-ID: <53C50859.5070209@gmail.com>
References: <1405049655-4265-1-git-send-email-tanayabh@gmail.com>	<1405049655-4265-2-git-send-email-tanayabh@gmail.com> <vpqlhs02cz7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 15 12:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X70NZ-0001KG-8W
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 12:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbaGOKy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 06:54:28 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34193 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbaGOKyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 06:54:24 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so4722279pdj.29
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eQoYEL00B+QZBHrJEkFXect5hq1a/6ojHpN9N4Arycw=;
        b=lKo+n5Qw7XN+/y4HdsSLWHjUAUFJU9PREPOqeP2R1CPkvIYi6lofLp8cdquRes3k/S
         Dy07esxwPGvPEu2m3OHxsu8RDn0rIr05OBTxhdaDc2bK914alvCwpqcxYRPBjk0WwkrC
         upMzMfw/VtbUaKka23WerBxEU5PJ6HBXHRbaq57heJyJqqVtb3bUaVs9NGUEPTmYYtxo
         VWgOp/ivhmpwvoiuxFESIkxB8DLC2Azu+txN/L0A/v1Q5egiT2MSzsRjaC29DUi9HrfP
         Ays8JCq/TksLhVMxaFSXCrSNVnrNS0NktbSH0sT12KXOMm7CUX7J3ey5RF51jG7JG0Ou
         fPbQ==
X-Received: by 10.68.201.167 with SMTP id kb7mr22413383pbc.38.1405421664264;
        Tue, 15 Jul 2014 03:54:24 -0700 (PDT)
Received: from [127.0.0.1] ([223.226.20.20])
        by mx.google.com with ESMTPSA id u8sm18129045pds.92.2014.07.15.03.54.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 03:54:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqlhs02cz7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253552>



On 7/11/2014 7:51 PM, Matthieu Moy wrote:
>> +`int git_configset_add_file(struct config_set *cs, const char *filename)`::
>> +
>> +	Parses the file and adds the variable-value pairs to the `config_set`,
>> +	dies if there is an error in parsing the file.
> 
> The return value is undocumented.
> 
> If I read correctly, the only codepath from this to a syntax error sets
> die_on_error, hence "dies if there is an error in parsing the file" is
> correct.
> 
> Still, there are errors like "unreadable file" or "no such file" that do
> not die (nor emit any error message, which is not very good for the
> user), and lead to returning -1 here.
> 
> I'm not sure this distinction is right (why die on syntax error and
> continue running on unreadable file?).
> 

I checked the whole codebase and in all of the cases if they cannot read a file
they return -1 and continue running. So, I have updated the API to document the
return value.

I think if the file is unreadable. we must continue running as no harm has been
done yet, worse is parsing a file with wrong syntax which can cause reading
wrong config values. So the decision to die on syntax error sounds alright
to me.

Cheers,
Tanay Abhra.
