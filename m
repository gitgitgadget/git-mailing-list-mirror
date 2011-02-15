From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Challenges for an octopus merge
Date: Tue, 15 Feb 2011 18:29:26 +0100
Message-ID: <4D5AB7F6.8040508@web.de>
References: <4D53F694.1060105@web.de> <7v8vxn6fdv.fsf@alter.siamese.dyndns.org> <4D55627F.30305@web.de> <7vd3my1leq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 18:31:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpOkC-0008K7-RY
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 18:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370Ab1BORbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 12:31:14 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:46984 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab1BORbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 12:31:14 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3C395197C3B9C;
	Tue, 15 Feb 2011 18:30:52 +0100 (CET)
Received: from [78.49.32.112] (helo=[192.168.1.46])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PpOjk-0003HO-00; Tue, 15 Feb 2011 18:30:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.13) Gecko/20101206 SUSE/3.1.7 Thunderbird/3.1.7
In-Reply-To: <7vd3my1leq.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX18MNQN5oTrQrjMdO46+aaEg1thJi9eQm5SpTNIZ
	jvUd+DCditVEakGVFM6fQcE76M2ARtcSkz1d2VE/Xh2cg2NCfA
	L/w2pW97i4rraW4oiTbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166859>

> The user needs to decide what to do next; the user may choose to do "git merge A C ; git merge B" instead,
> but *after* inspecting the situation.

I find a few of the applied conflict markers strange after my inspection.

1. They suggest to choose one of the involved changes. But how do you think 
about the situation if I found that the right resolution is to delete the 
conflict section completely?

    Why was the merging process not able to come to the same conclusion 
automatically?


2. My tenth patch would like to delete six consecutive lines in a source file in 
a way similar to the following example.

-drop 1 ...;
-drop 2 ...;
-drop 3 ...;
-drop 4 ...;
-
-
  void make_parser()

elfring@Sonne:~/Projekte/BtYacc/lokal2> git merge --stat --verbose -m 'Deletion 
of duplicated function declarations' double_declaration_deletion 

Auto-merging
mkpar.c 
 

CONFLICT (content): Merge conflict in mkpar.c 
 

Automatic merge failed; fix conflicts and then commit the result.


But the Git GUI displays this conflict like the following.

   <<<<<<< HEAD
  +drop 1 ...;
  +drop 2 ...;
  +drop 3 ...;
  +drop 4 ...;
  +
  +static void find_final_state(void)
   =======
+ void make_parser()
+ {
...
+ }
+
+ void find_final_state()
   >>>>>>> double_declaration_deletion


I find three details suspicious here.
- Why are these lines marked for addition again?
- Why is the function "find_final_state" referenced? (Does this indicate an 
off-by-one error in the first block?)
- Why are those parts like make_parser() not omitted that were moved to 
different places in this source file by a previous patch?


I would appreciate your advices.

Regards,
Markus
