From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 19:27:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510301925360.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <20151026191724.GE7881@google.com> <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:27:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEOx-00063k-BN
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760437AbbJ3S1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:27:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:62190 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760429AbbJ3S1k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:27:40 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MZ8fw-1aDCf50P7s-00KzwA;
 Fri, 30 Oct 2015 19:27:35 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:/FRrSDtEte2I70ByjoOGbe/hSlEYDfcRYwzawh3ndnyZN1KKQ3j
 PFJ9IAlSr+a9lGnqg6nA2vVie/BhAQqShoU87nRF+eTOIBrjr3XKklziLrRGG0gSZdFYm57
 2laokpDTutBq+vGLlmh7IZKgMVm8l2ek/csThVRg8zdQBHWtVxXKT9UiqcZDESFQsrZF7tt
 jOCldNkv2KxYQu2PjPjMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ofTmU9X1yCc=:xP/86zLXVVkWV5maj3VHVN
 Sjb+pKzwt4VgSGuujjWvrDPL7cOijTHcpui9Swah/lssiwHFFCwdb4hoyEwdOBgwdVjakMMO9
 TPjLVpHOLJm09UK7NHVOf9LpjhCtlaQzvN7T5g3acq1RcFkOPrDWfnbgz/2pcn5Y84SiuRbSM
 tFfE2h8ccS1VxMF1XSv/VXmJzOj2ScaWgcFXuAGxVN0y6XdtqSlcyacAocjaiGTPxig0fmIUY
 pzVsf4ya81JyYdEGsNSunZ6uD3cI2d709qjcOwNm+OyJkIjAKa3BJP1TklRUdmIVwPnHj/3mf
 l5tQR51GZ3dAdNgsgqwZiUexR/VFhdaymzgbRZ7pEIYXPVxhXI4mEAAIkuy0fm8IjX9pKCFHw
 Z+t3fnKPoc1HK3EHABlVUdiF+iFkLyv4k8kgjkyhSi2fsKa9qbmv3IAmUara2uR13pZtuO2Ts
 8Z/lwe9IGg/DFuBrpfhzc6ZiAQxFImPW2dTZayh+Nu2fbnBTwmSdwRxhHH79dZ/6SbcAP+BHo
 FVz3zqSMW97LaLkPQ3VwqeJ4w9kcbsYite8WpJ7Qjjq4JSBdaoN7kCgDnAfsD0hOS3v/aLOMv
 t4NCIMc1xm+jjY9902+ELDSnSOp/M7FP+ry4yQDDuC/e33BAvWgPGN9OTteYtqKg7duUOxVQK
 Fq5QhEvg1nUQw2SlJrrxUdnH/Q3prc73SXY3GiV7aYGlGkeeeIkz3NYFGtVYrtOm3Efh6C+kt
 jYu0/uRyO8IXwJmpv4xPdCgbF0luFKPJqm338S4GFZ65II671iBc15CBOewjGWk2uLtfkkO5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280511>

Hi Junio,

On Tue, 27 Oct 2015, Junio C Hamano wrote:

> It can be called GDB=1, perhaps?

No, this is way too generic. As I only test that the environment
variable's existence, even something like GDB=/usr/opt/gdb/bin/gdb would
trigger it.

I could be talked into GDB_GIT=1, though.

Ciao,
Dscho
