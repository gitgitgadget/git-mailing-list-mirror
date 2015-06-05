From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] status: give more information during rebase -i
Date: Fri, 5 Jun 2015 18:35:51 +0200 (CEST)
Message-ID: <261867654.193546.1433522151490.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <1433368825-24617-3-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <vpqfv67zylq.fsf@anie.imag.fr> <xmqqtwunv1bv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uaq-00035O-A0
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbbFEQff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:35:35 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:46394 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422745AbbFEQfe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 12:35:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1801D2870;
	Fri,  5 Jun 2015 18:35:32 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id alM9FFy8Rooa; Fri,  5 Jun 2015 18:35:32 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0670D284D;
	Fri,  5 Jun 2015 18:35:32 +0200 (CEST)
In-Reply-To: <xmqqtwunv1bv.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: status: give more information during rebase -i
Thread-Index: Cqu+ry5L2v2BbsHK8hIcj2g2XyZdzw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270853>

Junio C Hamano <gitster@pobox.com> writes

>Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes: 

>>> +void get_two_last_lines(char *filename, int *numlines, char **lines) 
>>> +{ 
>>> +... 
>>> +} 
>>> + 
>>> +void get_two_first_lines(char *filename, int *numlines, char **lines) 
>>> +{ 
>>> +... 
>>> +} 

>I had a handful of comments on these: 

>- Do we need two separate and overly specific functions like these, 
>i.e. "two" and "first/last"? 

>- Wouldn't people want to be able to configure the number of lines? 

>- Do we really want get_two_{first,last}_LINES() functions? 

>I am wondering if insn sheets these functions read include 
>comments, in which case get_n_{first,last}_commands() may be a 
>more correct name. 

>- Wouldn't it be necessary for these functions to report the total 
>number of commands, instead of giving "void" back? Otherwise how 
>would the caller produce summary like this: 

I felt that was not the right way to do so. What do you think of a
function like that:

/*
 * Puts nb_commands commands from filename in lines,
 * returns the total number of commands in the file
 * ignores comments and empty lines
 * lines needs to be at least of size nb_commands
 * part: 0 get last commands
 * 	 1 get first commands
 */

int get_commands(char *filename, int nb_commands, char **lines, int part)

Maybe part is not the best word to choose to take the beginning or the end
of the file. I also hesitate about adding a parameter to ignore or not the 
comments.
