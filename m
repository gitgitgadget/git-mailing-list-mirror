From: Steve Wagner <lists@lanwin.de>
Subject: Re: .gitk should created hidden in windows
Date: Mon, 23 Mar 2009 13:18:13 +0100
Message-ID: <49C77E05.80603@lanwin.de>
References: <49BFA97A.1030203@lanwin.de> <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 13:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llj8R-0003rR-Gk
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbZCWMSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbZCWMSL
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:18:11 -0400
Received: from lanwin.de ([77.37.16.229]:36955 "EHLO vs5923.vserver4free.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbZCWMSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 08:18:10 -0400
Received: from [10.10.11.46] (unknown [213.61.128.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by vs5923.vserver4free.de (Postfix) with ESMTP id D543B251FE;
	Mon, 23 Mar 2009 13:18:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.8.1.21) Gecko/20090302 Lightning/0.9 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
In-Reply-To: <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114294>

Seems to work here. Thanks for fixing it!

Steve

Paul Mackerras schrieb:
> Steve Wagner writes:
> 
>> The problem is that windows dose not hides files beginning with a dot as
>> it is in unix. So the .gitk file is created as visible in the windows
>> user profile. Problematic too is that i can no set the hidden attribute
>> to this file, because it is recreated every time i start gitk, so the
>> hidden attribute gets lost.
>>
>> Can you control this and create the file with the hidden attribute on
>> windows?
> 
> Please try this patch and let me know if it does what you want.
> 
> Paul.
> 
> diff --git a/gitk b/gitk
> index d7de27e..54f3f2b 100755
> --- a/gitk
> +++ b/gitk
> @@ -2487,6 +2487,9 @@ proc savestuff {w} {
>      if {![winfo viewable .]} return
>      catch {
>  	set f [open "~/.gitk-new" w]
> +	if {$::tcl_platform(platform) eq {windows}} {
> +	    file attributes "~/.gitk-new" -hidden true
> +	}
>  	puts $f [list set mainfont $mainfont]
>  	puts $f [list set textfont $textfont]
>  	puts $f [list set uifont $uifont]
> 
