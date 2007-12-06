From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Git and GCC. Why not with fork, exec and pipes like in linux?
Date: Thu, 6 Dec 2007 21:37:32 +0100
Message-ID: <998d0e4a0712061237j6ed43aaav5934e4fe63398233@mail.gmail.com>
References: <998d0e4a0712061125h3d44139ctb7f5600bc8467292@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,  	"Daniel Berlin" <dberlin@dberlin.org>,  	"Harvey Harrison" <harvey.harrison@gmail.com>,  	"David Miller" <davem@davemloft.net>, ismail@pardus.org.tr,  	gcc@gcc.gnu.org, git@vger.kernel.org
To: "Jon Smirl" <jonsmirl@gmail.com>,  	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: gcc-return-142769-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 21:38:08 2007
Return-path: <gcc-return-142769-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0NTr-00089d-5G
	for gcc@gmane.org; Thu, 06 Dec 2007 21:37:59 +0100
Received: (qmail 16361 invoked by alias); 6 Dec 2007 20:37:41 -0000
Received: (qmail 16347 invoked by uid 22791); 6 Dec 2007 20:37:40 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.183)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 20:37:35 +0000
Received: by py-out-1112.google.com with SMTP id a29so1148441pyi         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 12:37:33 -0800 (PST)
Received: by 10.142.12.14 with SMTP id 14mr1930907wfl.1196973452743;         Thu, 06 Dec 2007 12:37:32 -0800 (PST)
Received: by 10.70.54.17 with HTTP; Thu, 6 Dec 2007 12:37:32 -0800 (PST)
In-Reply-To: <998d0e4a0712061125h3d44139ctb7f5600bc8467292@mail.gmail.com>
Content-Disposition: inline
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67336>

On 2007/12/6, J.C. Pizarro <jcpiza@gmail.com>, i wrote:
> For multicores CPUs, don't divide the work in threads.
> To divide the work in processes!
>
> Tips, tricks and hacks: to use fork, exec, pipes and another IPC mechanisms like
> mutexes, shared memory's IPC, file locks, pipes, semaphores, RPCs, sockets, etc.
> to access concurrently and parallely to the filelocked database.

I'm sorry, we don't need exec. We need fork, pipes and another IPC mechanisms
because it so shares easy the C code for parallelism.

Thanks to Linus because GIT is implemented in C language to interact with
system calls of the kernel written in C.

> For Intel Quad Core e.g., x4 cores, it need a parent process and 4
> child processes linked to the parent with pipes.

For peak performance (e.g 99.9% usage), the minimum number of child
processes should be more than 4, normally between e.g. 6 and 10 processes
depending on the statistics of idle's stalls of the cores.

> The parent process can be
> * no-threaded using select/epoll/libevent
> * threaded using Pth (GNU Portable Threads), NPTL (from RedHat) or whatever.

Note: there is a little design's problem with slowdown of I/O bandwith when
the parent is multithreaded and the children MUST to be multithreaded that
we can't avoid them to be non-multithreaded for maximum I/O bandwith.

The "finding of the smallest spanning forest with deltas" consumes a lot of
CPU, so if it scales well in a CPU x4 cores then it can to reduce 4
hours to 1 hour.

   J.C.Pizarro :)
